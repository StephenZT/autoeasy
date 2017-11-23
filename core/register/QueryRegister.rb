# encoding=utf-8
#Author: Stephen Zhang
#Register query script that can be used in whole project
#Examples
# customerQuery = "SELECT A.*
    # FROM Customer A WITH (NOLOCK)
  # WHERE %{queryParam} and %{queryParam}
  # order BY A.CreateDate desc"
# 
# q = QueryRegister.transferQuery(customerQuery,
  # {
    # "queryParam" => "A.AccountKey=%{accountKey}"
  # }
# )
# 
# QueryRegister.registerQuery('q_customer',q)
# puts QueryRegister.getQuery('q_customer', {'accountKey'=>'123456'})

module AutoEasy
  module Core
    class QueryRegister
      include Singleton
      
      def initialize()
        @registered_queries = Hash.new  
      end
      
      def registerQuery(name, query, opts={})
        raise "Query name #{name} already exist, please register it with another name." if @registered_queries.key?(name)
        @registered_queries[name] = query
      end
      
      def getQuery(name, args={})
        raise "Query name #{name} does not registered." if !@registered_queries.key?(name)
        return transferQuery(@registered_queries[name],args) 
      end
      
      def transferQuery(query, args={})
        query.scan(/%{.*?}/).each do |s|
          k = s.to_s.gsub(/^%{/, "").gsub(/}$/, "")
          query = query.gsub(s,args[k]) if args.key?(k)
        end
        return query
      end
    end
  end
end

G_QueryRegister ||= AutoEasy::Core::QueryRegister.instance



