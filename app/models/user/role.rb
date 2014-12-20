class User::Role < ActiveRecord::Base
  has_many :users

  def self.user
    find(1)
  end

  def self.manager
    find(2)
  end

  def self.admin
    find(3)
  end

  def self.super_user
    find(4)
  end

  validates :name, presence: true

  def to_s
    "#{ name.titleize unless name.nil? }"
  end
end
