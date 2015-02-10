class User < ActiveRecord::Base

  # Temporary fix for token auth
  before_save -> do
    # self.uid = SecureRandom.uuid
    skip_confirmation!
  end
  
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :omniauthable

  include DeviseTokenAuth::Concerns::User
  
  belongs_to :role, class_name: 'User::Role', foreign_key: 'user_role_id'
  before_create :create_role, unless: :has_role?
  
  belongs_to :group, class_name: 'User::Group', foreign_key: 'user_group_id'
  before_create :create_group, unless: :has_group?

  belongs_to :temporary_role, class_name: 'User::Role', foreign_key: 'temporary_role_id'

  def to_s
    "#{ name.titleize unless name.nil? }"
  end

  def admin?
    # return temporary_role.admin? if temporary_role_expired?
    role.admin? || group.admin?
  end

  def manager?
    return temporary_role.manager? if temporary_role_expired?
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

    def temporary_role_expired?
      temporary_role_expires_at && Time.now < temporary_role_expires_at
    end
end
