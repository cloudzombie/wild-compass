module SetWeightable
  extend ActiveSupport::Concern

  included do
    before_action :set_message,  only: [ :create, :update ]
    before_action :set_weight,   only: [ :create, :update ]
    before_action :set_quantity, only: [ :create, :update ]
  end

  def set_message
    bag.message = params.require(model_name)[:message]
  end

  def set_quantity
    bag.quantity = params.require(model_name)[:quantity]
  end

  def set_weight
    bag.weight = params.require(model_name)[:weight]
  end

  private

    def model_name
      controller_name.classify.downcase.to_sym
    end

end