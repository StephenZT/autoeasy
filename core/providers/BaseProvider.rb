#encoding=utf-8
#Author: Stephen Zhang
#Base class for all test data provider

module AutoEasy
  module Core
    class BaseProvider
      attr_reader :data
      
      def initialize(opts={})
        if(opts != nil)
          @data = opts
        else
          @data = Hash.new
        end  
      end
      #Get test data by given key
      #key input format: 0:1:key1:key2
      def getData(key)
        raise "No data availabe" if @data == nil
        current_it = @data
        
        key_map = key.split(":")
        key_map.each do |it|
          current_it = current_it[it]
          raise "No data availabe for given #{key}" if current_it == nil
        end
        return current_it
      end
      
      #key input format: 0:1:key1:key2
      def addData(key, value)
        key_map = key.split(":")
        is_root = true
        current_it = @data
        last_key = key_map.last
        key_map.each do |it|
          if(current_it.key?(it))
            raise "This key already used as ['#{key}' => '#{current_it[it].to_s}']" if it == last_key
            current_it = current_it[it]
          else
            if(it == last_key)
              current_it[it] = value
            else
             current_it[it] = Hash.new
             current_it= current_it[it]
            end
          end
        end
      end
    end
  end
end

# provider = AutoEasy::Core::BaseProvider.new
# provider.addData("test",'abcd')
# provider.addData("0:1:a:b",'xxxx')
# provider.addData("0:1:c",'ddd')
# puts provider.data
# puts provider.getData('0:1:a:b')
# puts provider.getData('test')
# puts provider.getData('0:1:c')

