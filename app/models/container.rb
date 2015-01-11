class Container < ActiveRecord::Base

	belongs_to :lot

	has_many :bags

	has_many :plants

	### Strain
	has_one :strain, through: :lot


  def to_s
    "#{ name.upcase unless name.nil? }"
  end
end
