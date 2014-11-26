class Status < ActiveRecord::Base
  def name
    name.titleize
  end

  def to_s
    "#{ name unless name.nil? }"
  end
end
