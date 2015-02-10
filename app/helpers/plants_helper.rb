module PlantsHelper
	def status_btn_color_for (status)
		case status
			when "growing", "harvest"
				"btn-success"
			when "curing", "drying"
				"btn-warning"
			when "destroyed"
				"btn-primary"
		end
	end

	def status_color_for(status)
		case status.to_s.downcase.to_sym
		when :destroyed
			'danger'
		else
			''
		end
	end
end
