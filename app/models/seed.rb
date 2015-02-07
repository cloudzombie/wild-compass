class Seed < ActiveRecord::Base

  belongs_to :plant

  validates :plant_id, presence: true, uniqueness: true

end
