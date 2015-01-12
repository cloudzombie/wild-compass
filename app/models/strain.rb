class Strain < ActiveRecord::Base

  has_many :plants

  has_many :lots, through: :plants

  has_many :bags, through: :lots

  has_many :jars, through: :bags
  

  belongs_to :brand

  before_save :upcase_acronym

  def to_s
    "#{ acronym.upcase unless acronym.nil? }"
  end

  def total_weight
    plants.total_weight + lots.total_weight + bags.total_weight + jars.total_weight
  end

  private

    def upcase_acronym
      self.acronym = acronym.to_s.upcase
    end
end
