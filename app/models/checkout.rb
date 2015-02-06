class Checkout < ActiveRecord::Base
  belongs_to :target, polymorphic: true
  belongs_to :user

  validates :target_id,   presence: true, uniqueness: { scope: [ :target_type, :target_id ]}
  validates :target_type, presence: true, uniqueness: { scope: [ :target_type, :target_id ]}
end
