#encoding=utf-8
#Author: Stephen Zhang
#Base class for all cucumber steps

module AutoEasy
  module Core
    class StepProvider
      attr_reader :steps
      
      def initialize()
        @steps = []
      end
      
      def addStep(step)
        @steps.push(step)
      end
      
      def getSteps()
        return @steps
      end
    end
  end
end