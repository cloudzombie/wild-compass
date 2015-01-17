class Plant < ActiveRecord::Base

  include Weightable
  include Accountable
  include Storyable



  scope :strains, -> (strain = nil) { where(strain: strain) }



  belongs_to :strain

  belongs_to :format

  belongs_to :status

  belongs_to :rfid



  belongs_to :lot
  
  has_many :containers, through: :lot

  has_many :bags, through: :lot

  has_many :jars, through: :lot



  ### Utils
  
  def to_s
    "Plant - #{ id unless id.nil? }"
  end

end