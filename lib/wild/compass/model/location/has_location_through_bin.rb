module Wild::Compass::Model::Location::HasLocationThroughBin
  extend ActiveSupport::Concern

  included do
    belongs_to :bin
    has_one :location, through: :bin
  end
  
end