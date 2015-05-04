class Wild::Compass::Template::Engine

  class EngineError < StandardError
  end

  class NilModel < EngineError
  end
  
  attr_accessor :config, :model

  def initialize(model)
    raise NilModel, "Model cannot be nil" if model.nil?
    self.model = model
    self.config = {}
    yield config
  end

  def attributes
    model.columns
  end

end
