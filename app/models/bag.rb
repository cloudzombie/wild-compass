class Bag < ActiveRecord::Base
  belongs_to :lot

  has_many :pots

  has_many :plants, through: :lot
end
