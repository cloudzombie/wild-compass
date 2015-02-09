class Seed < ActiveRecord::Base

  include Weightable
  include Searchable

  has_many :plants

  def to_s
    "#{ name.titleize unless name.nil? }"
  end

end
