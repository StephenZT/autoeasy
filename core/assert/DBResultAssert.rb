module AutoEasy
  module Core
    class DBResultAssert
      attr_reader :action
      attr_reader :assert
      
      def initialize(dbresult_act, opts={})
        @action = dbresult_act
        @assert = AutoEasy::Core::Assert.new(opts)
      end
      
      def assert_size(assertion, value)
        @assert.assert("Assert query result size.", @action.size, value, assertion)
      end
      
      def assert_data_exist(condition={})
        @assert.assert("Assert query result exist rows meet given condition #{condition.to_s}.", @action.get_rows_meet_condition(condition).size, 0, ">")
      end

      def assert_data_not_exist(condition={})
        @assert.assert("Assert query result exist rows not meet given condition #{condition.to_s}.", @action.get_rows_meet_condition(condition).size, 0, "==")
      end
      
      def assert_data_exist_rows(condition={}, rowcount)
        @assert.assert("Assert query result exist #{rowcount} rows meet given condition #{condition.to_s}.", @action.get_rows_meet_condition(condition).size, rowcount, "==")
      end
      
      def assert_data_not_exist_rows(condition={}, rowcount)
        @assert.assert("Assert query result exist #{rowcount} rows not meet given condition #{condition.to_s}.", @action.get_rows_not_meet_condition(condition).size, rowcount, "==")
      end
      
      def assert_data_match_exist(condition={})
        @assert.assert("Assert query result exist rows match given condition #{condition.to_s}.", @action.get_rows_match_condition(condition).size, 0, ">")
      end
      
      def assert_data_not_match_exist(condition={})
        @assert.assert("Assert query result exist rows not match given condition #{condition.to_s}.", @action.get_rows_match_condition(condition).size, 0, ">")
      end
      
      def assert_data_match_exist_rows(condition={}, rowcount)
        @assert.assert("Assert query result exist #{rowcount} rows match given condition #{condition.to_s}.", @action.get_rows_match_condition(condition).size, rowcount, "==")
      end
      
      def assert_data_not_match_exist_rows(condition={}, rowcount)
        @assert.assert("Assert query result exist #{rowcount} rows not match given condition #{condition.to_s}.", @action.get_rows_not_match_condition(condition).size, rowcount, "==")
      end
      
    end
  end
end
      
