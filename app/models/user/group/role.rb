class User::Group::Role < ActiveRecord::Base
  has_many :user_groups
end
