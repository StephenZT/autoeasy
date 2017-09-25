# encoding=utf-8
#Author: Stephen Zhang
#Example
# database = {:dataserver=>'tt',:database=>'tt'}
# begin
  # sqlclient = AutoEasy::Core::SqlClient.new(database)
  # result = sqlclient.executeQuery("select top 1 * from customer")
  # puts result
  # sqlclient.execute_transaction() {puts 'query executed'}
# ensure
  # puts 'close'
  # sqlclient.close_client
# end


require 'tiny_tds'

module AutoEasy
  module Core
    class SqlClient
      TINYTDS_SCHEMAS = ['sqlserver_2000', 'sqlserver_2005', 'sqlserver_2008', 'sqlserver_2014', 'sqlserver_azure', 'sybase_ase'].freeze
      
      attr_reader :client
      attr_reader :schema
      attr_reader :db_allow_max_results_count
      
      #opts {:dataserver=>'abc',:database=>'bcd'}
      def initialize(opts={})
        if !opts.key?(:dataserver) then
          raise "Please identify database server with key :dataserver"
        end
        if !opts.key?(:database) then
          raise "Please identify database name with key :database"
        end
        if opts.key?(:schema) then
          @schema = opts[:schema]
        else
          @schema = 'sqlserver_2000'
        end
        
        if opts.key?(:db_allow_max_results_count) then
          @db_allow_max_results_count = opts[:db_allow_max_results_count]
        else
          @db_allow_max_results_count = 100
        end

        @client = new_connection(opts)
      end
      
      def executeQuery(query)
        arr = []
        result = client.execute(query)
        count = 0
        result.each do |item|
          arr.push(item)
          count = count + 1
          if count >= @db_allow_max_results_count
            break
          end
        end
        return arr
      end
      
      def executeNoQuery(query)
        result = client.execute(query)
        return result.affected_rows 
      end
      
      def current_schema
        return @schema
      end
      
       def new_connection(options={})
        client = TinyTds::Client.new(connection_options(options))
        if sybase_ase?
          client.execute("SET ANSINULL ON").do
          return client
        elsif sqlserver_azure?
          client.execute('SET ANSI_NULLS ON').do
          client.execute('SET CURSOR_CLOSE_ON_COMMIT OFF').do
          client.execute('SET ANSI_NULL_DFLT_ON ON').do
          client.execute('SET IMPLICIT_TRANSACTIONS OFF').do
          client.execute('SET ANSI_PADDING ON').do
          client.execute('SET QUOTED_IDENTIFIER ON').do
          client.execute('SET ANSI_WARNINGS ON').do
        else
          client.execute('SET ANSI_DEFAULTS ON').do
          client.execute('SET CURSOR_CLOSE_ON_COMMIT OFF').do
          client.execute('SET IMPLICIT_TRANSACTIONS OFF').do
        end
        client.execute('SET TEXTSIZE 2147483647').do
        client.execute('SET CONCAT_NULL_YIELDS_NULL ON').do
        client
      end
    
      def connection_options(options={})
        { 
          :appname       => 'AutoEasy',
          :login_timeout => 5,
          :timeout       => connection_timeout,
          :azure         => sqlserver_azure?
        }.merge(options)
      end
      
      def close_client()
        @client.close if defined?(@client) && @client.is_a?(TinyTds::Client)
      end
      
      def sqlserver?
        current_schema =~ /sqlserver/
      end
      
      def sqlserver_azure?
        current_schema =~ /sqlserver_azure/
      end
      
      def sybase_ase?
        current_schema =~ /sybase_ase/
      end
      
      def connection_timeout
        sqlserver_azure? ? 20 : 180
      end
      
      def execute_transaction()
        raise "Client connection not ready" if @client == nil
        begin
          @client.execute("BEGIN TRANSACTION").do
          yield
          @client.execute("COMMIT")
        rescue
          @client.execute("ROLLBACK TRANSACTION").do
        end
      end
    
    end
  end
end

