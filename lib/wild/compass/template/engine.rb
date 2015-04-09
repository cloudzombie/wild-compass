class Wild::Compass::Template::Engine
  
  attr_accessor :config

  @@instances = {}
  
  class << self
    def load(model)
      engine = @@instances[model] ||= instance_for(model)
      yield engine.config ||= Config.instance_for(model)
      engine
    end

    def instance_for(model)
      @@instances[model] ||= new(model)
    end
  end

  def initialize(model)
    @model = model
  end

  def columns
    @model.columns
  end

  def attributes
    @model.columns
  end

  class Config
    @@instances = {}

    def self.instance_for(model)
      @@instances[model] ||= Config.new
    end

    def initialize
      @attributes = []
    end

    def unload(attribute)
      @attributes.delete(attribute)
    end

    def load(attribute)
      @attributes << attribute
    end
  end

end
