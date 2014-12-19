class Bag < ActiveRecord::Base

  #######################
  ### Bag             ###
  #######################
  ### lot:    Lot     ###
  ### jars:   Jar[]   ###
  ### plants: Plant[] ###
  ### weight: int     ###
  #######################

  before_create :create_history
  before_save :create_history, unless: :history_exists?

  ### History

  belongs_to :history



  ### Lot

  belongs_to :lot



  ### Jars

  has_many :jars



  ### Plants

  has_many :plants, through: :lot

  def to_s
    "#{ name.titleize unless name.nil? }"
  end

  private

    def create_history
      self.history = History.create
    end

    def history_exists?
      !history.nil?
    end

end
