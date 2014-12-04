module PlantsHelper
<<<<<<< HEAD
	def status_btn_color_for (status)
=======
	def status_btn_color_for(status)
>>>>>>> b9b392026107ab39f1de2b0dd51f5c381eeec9f9
		case status
			when "growing", "harvest"
				"btn-success"
			when "curing", "drying"
				"btn-warning"
			when "destroyed"
				"btn-primary"
		end
	end
end
