module Wild::Compass::Model::Bag::HasBagStatus
  extend ActiveSupport::Concern

  included do
    has_one :status, class_name: 'Bags::Status'

    validates :status, presence: true

    before_validation :create_status, unless: :has_status?
  end

  def has_status?
    !status.nil?
  end

  def create_status
    self.status = Bags::Status.new
  end
  
end