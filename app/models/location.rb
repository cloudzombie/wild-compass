class Location < ActiveRecord::Base

	has_many :plants
	
	has_many :containers
	
	has_many :bins





	def to_s
    	"#{ description.upcase unless name.nil? }"
	end
end
