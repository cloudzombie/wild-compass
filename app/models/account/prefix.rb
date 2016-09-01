class Account::Prefix < ActiveRecord::Base

  has_many :accounts,
    foreign_key: 'account_prefix_id',
    as: 'prefix'

  validates :name,
    presence: true

  def to_s
    name
  end

  before_save -> { self.name = self.name.upcase }

end
