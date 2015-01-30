module Storyable
  extend ActiveSupport::Concern

  included do
    belongs_to :history, dependent: :destroy
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
end

