module Wild::Compass::Model::Jar::HasJarStatus
  extend ActiveSupport::Concern

  included do
    has_one :status, class_name: 'Jars::Status'

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