class Plant < ActiveRecord::Base

  include Weightable
  include Accountable
  include Storyable



  scope :strains, -> (strain = nil) { where(strain: strain) }



  belongs_to :strain

  belongs_to :format

  belongs_to :status

  belongs_to :rfid


  
  has_and_belongs_to_many :containers

  has_many :lots, through: :containers

  has_many :bags, through: :containers

  has_many :jars, through: :containers



  ### Utils
  
  def to_s
    "Plant - #{ id unless id.nil? }"
  end

  def container
    containers.first
  rescue
    ''
  end

  def bag
    bags.first
  rescue
      ''
  end

  def lot
    lots.first
  rescue
    ''
  end

  def jar
    jars.first
  rescue
    ''
  end

end