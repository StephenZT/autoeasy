# encoding=utf-8
#Author: Stephen Zhang

require 'singleton'

module AutoEasy
  module Core
    class DBHelper
      include Singleton
        
      attr_accessor :db_results
      
      def initialize(opts={})
        @db_results = Hash.new
      end
      
      def get_result(name)
        raise "There is no result : #{name}" if !@db_results.key?(name)
        return @db_results[name]
      end
      
      def query_default_db(resultname,queryname,queryargs)
        return query(resultname,queryname,queryargs,G_ConfigHelper.get_default_database()) 
      end
      
      #Example query('my_result','my_reg_query_name','{'arg1'=>123}',{:database => "dbname",:dataserver => "servername"})
      def query(resultname,queryname,queryargs,dbconifgs)
        begin
          sqlclient = AutoEasy::Core::SqlClient.new(dbconifgs)
          query = G_QueryRegister.getQuery(queryname,queryargs)
          result = sqlclient.executeQuery(query)
          @db_results[resultname] = result
        rescue Exception =>msg
          puts msg
        ensure
          sqlclient.close_client
        end
      end
             
    end
  end
end

G_DBHelper ||= AutoEasy::Core::DBHelper.instance
