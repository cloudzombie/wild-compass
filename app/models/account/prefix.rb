class Account::Prefix < ActiveRecord::Base
  has_many :accounts, foreign_key: 'account_prefix_id'

  validates :name, presence: true

  before_save -> { self.name = self.name.upcase }

  def to_s
    name
  end
end
