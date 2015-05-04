class Weight < ActiveRecord::Base
  
  validates :value, presence: true

  validates :weighted_at, presence: true

end
