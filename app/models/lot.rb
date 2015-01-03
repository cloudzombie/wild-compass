class Lot < ActiveRecord::Base

  include Weightable
  include Accountable

  scope :trims,   -> { where(category: 'Trim') }
  scope :buds,    -> { where(category: 'Buds') }
  scope :strains, -> (strain = nil) { where(strain: strain) }



  ### History

  belongs_to :history
  before_create :create_history
  before_save :create_history, unless: :history_exists?



  ### Strain

  belongs_to :strain



  ### Plants

  has_many :plants



  ### Bags
  
  has_many :bags



  ### Jar

  has_many :jars, through: :bag




  def to_s
    "#{ name.upcase unless name.nil? }"
  end

  private

    def create_history
      self.history = History.create
    end

    def history_exists?
      !history.nil?
    end

end
