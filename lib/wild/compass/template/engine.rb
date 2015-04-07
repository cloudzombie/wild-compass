class Engine
  def initialize(model)
    @attributes = []
    @unloaded_attributes = []

    model.column_names.each do |name|
      register_attribute(name)
    end
  end

  def unload_attribute(attribute)
    @unloaded_attributes << attribute
  end

  def reload_attribute(attribute)
    @unloaded_attributes.delete(attribute)
  end

  def attributes
    @attributes - @unloaded_attributes
  end

  private

    def register_attribute(name)
      self.attributes << name
    end

end