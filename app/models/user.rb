class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  belongs_to :role, class_name: 'User::Role', foreign_key: 'user_role_id'
  before_create :create_role, unless: :has_role?
  
  belongs_to :group, class_name: 'User::Group', foreign_key: 'user_group_id'
  before_create :create_group, unless: :has_group?

  def to_s
    "#{ name.titleize unless name.nil? }"
  end

  def admin?
    role.admin? || group.admin?
  end

  def manager?
    role.manager? || group.manager?
  end

  private

    def create_role
      self.role = User::Role.user
    end

    def has_role?
      !role.nil?
    end

    def create_group
      self.group = User::Group.users
    end

    def has_group?
      !group.nil?
    end
end
