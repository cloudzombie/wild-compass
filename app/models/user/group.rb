class User::Group < ActiveRecord::Base
  has_many :users
  belongs_to :user_group_role

  def admin?
    user_group_role.admin?
  end

  def manager?
    user_group_role.manager?
  end
end
