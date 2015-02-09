module Storyable
  extend ActiveSupport::Concern

  included do
    belongs_to :history, dependent: :destroy
    before_save :create_history, unless: :history_exists?
    before_destroy :log_history
  end

  def initialize(args = {})
    super
    create_history unless history_exists?
  end

  private

    def create_history 
      self.history = History.create
    end

    def history_exists?
      !history.nil?
    end

    def log_history
      Rails.logger.info "#{Time.now} --- Destroying #{self}"
      Rails.logger.info "#{Time.now} --- Logging history for #{self}"
      Rails.logger.info "#{Time.now} --- #{history}"
      history.history_lines.each do |line|
        Rails.logger.info "#{Time.now} --- #{line}"
      end
    end

end

