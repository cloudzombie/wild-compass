class Container < ActiveRecord::Base

	has_many :bags

	belongs_to :lot

end
