class Plant < ActiveRecord::Base

  include Weightable
  include Accountable

  
  

  ### History

  before_create :create_history
  before_save :create_history, unless: :history_exists?
  belongs_to :history



  ### Strain

  belongs_to :strain



  ### Format

  belongs_to :format



  ### Status

  belongs_to :status



  ### RFID

  belongs_to :rfid


  ### Lot

  belongs_to :lot



  ### Utils
  
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