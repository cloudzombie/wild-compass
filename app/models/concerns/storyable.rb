module Storyable
  extend ActiveSupport::Concern

  included do
    belongs_to :history, dependent: :destroy

    before_destroy :log_history

    before_create :create_history, unless: :history_exists?
  end

  private

    def create_history 
      self.history = History.new
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

