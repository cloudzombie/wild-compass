class User::Role < ActiveRecord::Base

  def self.user
    find_by(name: 'user')
  end

  def self.manager
    find_by(name: 'manager')
  end

  def self.admin
    find_by(name: 'admin')
  end

  def self.super_user
    find_by(name: 'super_user')
  end

  ADMIN      = User::Role.admin
  MANAGER    = User::Role.manager
  USER       = User::Role.user
  SUPER_USER = User::Role.super_user

  has_many :users

  validates :name, presence: true

  def to_s
    "#{ name.titleize unless name.nil? }"
  end
end
