class Strain < ActiveRecord::Base

	has_many :lots

  has_many :plants

  def to_s
    "#{ name.upcase unless name.nil? }"
  end
end
