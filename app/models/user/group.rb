class User::Group < ActiveRecord::Base
  has_many :users

  belongs_to :role, class_name: 'User::Group::Role', foreign_key: 'user_group_role_id'

  def admin?
    role.admin? || false
  end

  def manager?
    role.manager? || false
  end

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

  validates :name, presence: true

  def to_s
    "#{ name.titleize unless name.nil? }"
  end
end
