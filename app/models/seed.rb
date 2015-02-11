class Seed < ActiveRecord::Base

  include Weightable
  include Searchable
  include Encodable
  include Storyable
  include Sortable

  has_many :plants


  has_many :lots, through: :plants
  has_many :containers, through: :plants
  has_many :bags, through: :plants
  has_many :jars, through: :plants
  has_many :strains, -> { uniq } ,through: :plants
  

  

  delegate :category, to: :container, prefix: false, allow_nil: true

  has_one :location, through: :bin
  

  def to_s
    "#{ name.titleize unless name.nil? }"
  end

  def strain
    strains.first
  end
end
