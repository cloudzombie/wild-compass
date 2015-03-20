module Wild
  module Compass
    module Math
      def compute_delta(previous, last, current_weight, initial_weight)
        if previous.nil? 
          y = current_weight
        else
          y = previous.quantity
        end
          
        if last.nil?
          x = initial_weight
        else
          x = last.quantity
        end

        y - x
      end
    end
  end
end