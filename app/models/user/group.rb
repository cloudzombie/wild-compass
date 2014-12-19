class User::Group < ActiveRecord::Base
  has_many :users
end
