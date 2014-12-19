class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :group, class_name: 'User::Group', foreign_key: 'user_group_id'
  belongs_to :role, class_name: 'User::Role', foreign_key: 'user_role_id'

  def to_s
    "#{ name.titleize unless name.nil? }"
  end

  def admin?
    role.admin? || group.admin?
  end

  def manager?
    role.manager? || group.manager?
  end
end
