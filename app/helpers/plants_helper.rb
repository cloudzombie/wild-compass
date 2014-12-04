module PlantsHelper
	def status_btn_color_for
		case plants.status
			when "growing", "harvest"
				"btn-success"
			when "curing", "drying"
				"btn-warning"
			when "destroyed"
				"btn-primary"
		end
	end
end