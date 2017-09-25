# encoding=utf-8
#Author: Stephen Zhang

require 'singleton'

module AutoEasy
  module Core
    class DBHelper
      include Singleton
        
      attr_accessor :db_results
      attr_accessor :db_allow_max_results_count
      
      def initialize(opts={})
        @db_results = Hash.new
      end
      
      def get_result(name)
        return nil if !@db_results.key?(name)
        return @db_results[name]
      end
      
      def query_default_db(resultname,queryname,queryargs={})
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
          if sqlclient != nil then
            sqlclient.close_client
          end
        end
      end
      
      def action(resultname,opts={})
        return AutoEasy::Core::DBResultAction.new(get_result(resultname),opts)
      end
      
      def assert(resultname,opts={})
        return AutoEasy::Core::DBResultAssert.new(action(resultname,opts),opts)
      end
             
    end
  end
end

G_DBHelper ||= AutoEasy::Core::DBHelper.instance
