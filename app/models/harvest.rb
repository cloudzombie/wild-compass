class Harvest < ActiveRecord::Base

  include Accountable

  has_many :plants

  def to_s
    "#{class_name}-#{id}"
  end
 
  alias_method :name, :to_s

end
