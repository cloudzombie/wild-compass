class Bags::Status < ActiveRecord::Base
  has_many :bags, foreign_key: 'bags_status_id'
end
