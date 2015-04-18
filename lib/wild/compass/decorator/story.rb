module Wild::Compass::Decorator::Story

  def update(user, opts)
    if model.update(opts)
      model.history.add_line(model, model, nil, :story, user, "#{user} updated #{model} with #{opts}")
      model
    else
      false
    end
  end

  alias_method :update_attributes, :update

end