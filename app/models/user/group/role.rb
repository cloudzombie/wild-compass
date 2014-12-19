class User::Group::Role < ActiveRecord::Base
  has_many :user_groups

  def self.users
    find(1)
  end

  def self.managers
    find(2)
  end

  def self.admins
    find(3)
  end

  def self.super_users
    find(4)
  end
end
