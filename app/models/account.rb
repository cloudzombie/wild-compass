class Account < ActiveRecord::Base
  validates :number, presence: true
end
