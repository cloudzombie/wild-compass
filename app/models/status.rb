class Status < ActiveRecord::Base

  def to_s
    "#{ self[:name].to_s.titleize unless self[:name].nil? }"
  end

  alias_method :name, :to_s
  
end
