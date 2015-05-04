module Wild::Compass::Decorator::Story

  def update(user, params)
    @before = model.attributes
    @after = params

    if model.update(params)
      model.history.add_line(model, model, nil, :story, user, "#{user} updated #{model}'s #{changed_attributes}")
      model
    else
      false
    end
  end

  alias_method :update_attributes, :update

  private

    def changed_attributes
      @after.map{ |k,v| changed?(k,v) ? "#{identifier(k)} (#{display_value(k,v)})" : next }.compact.to_sentence
    end

    def identifier(k)
      case k
      when :name, "name"
        "ID"
      when /_id/
        k.sub /_id/, ''
      else
        k
      end
    end

    def display_value(k,v)
      case k
      when /_id/
        if m = k.sub(/_id/,'').classify.constantize
          m.find(v)
        else
          v
        end
      else
        v
      end
    end

    def changed?(k,v)
      return true if @before.key?(k) && @before[k] != v
      false
    end

end