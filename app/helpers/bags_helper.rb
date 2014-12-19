module BagsHelper

	def percent_of_weight(current_weight, initial_weight)
		current_weight = bag.current_weight
		initial_weight = bag.initial_weight
		current_weight.to_f / initial_weight.to_f * 100
  	end

end
