module Storyable
  extend ActiveSupport::Concern

  included do
    belongs_to :history, dependent: :destroy
    before_create :create_history, unless: :history_exists?
    before_validation :create_history, unless: :history_exists?
  end

  private

    def create_history 
      self.history = History.create
    end

    def history_exists?
      !history.nil?
    end
end

