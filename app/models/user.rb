class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :user_group
  belongs_to :user_role

  def to_s
    "#{ name.titleize unless name.nil? }"
  end

  def admin?
    user_role.admin? || user_group.admin?
  end

  def manager?
    user_role.manager? || user_group.manager?
  end
end
