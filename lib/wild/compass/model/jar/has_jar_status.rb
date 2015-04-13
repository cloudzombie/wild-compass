module Wild::Compass::Model::Jar::HasJarStatus
  extend ActiveSupport::Concern

  included do
    has_one :status, class_name: 'Jars::Status'

    [:sent_to_lab, :is_destroyed].each do |s|
      delegate :"#{s}",  to: :status
      delegate :"#{s}=", to: :status
      delegate :"#{s}?", to: :status
    end

    validates :status, presence: true

    before_validation :create_status, unless: :has_status?
  end

  def has_status?
    !status.nil?
  end

  def create_status
    self.status = Jars::Status.new
  end
  
end