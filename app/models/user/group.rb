class User::Group < ActiveRecord::Base

  def self.users
    find_by(name: 'users')
  end

  def self.managers
    find_by(name: 'managers')
  end

  def self.admins
    find_by(name: 'admins')
  end

  def self.super_users
    find_by(name: 'super_users')
  end

  USERS       = User::Group.users
  MANAGERS    = User::Group.managers
  ADMINS      = User::Group.admins
  SUPER_USERS = User::Group.super_users

  has_many :users

  belongs_to :role, class_name: 'User::Group::Role', foreign_key: 'user_group_role_id'

  def admin?
    role.admin? || false
  end

  def manager?
    role.manager? || false
  end

  validates :name, presence: true

  def to_s
    "#{ name.titleize unless name.nil? }"
  end
end
