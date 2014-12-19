class Strain < ActiveRecord::Base

	has_many :lots

  def to_s
    "#{ name.upcase unless name.nil? }"
  end
end
