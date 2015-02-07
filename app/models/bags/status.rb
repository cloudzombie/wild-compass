class Bags::Status < ActiveRecord::Base
  has_many :bags, foreign_key: 'bags_status_id'

  def to_s
    "#{ name.titleize unless name.nil? }"
  end
end
