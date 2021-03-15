class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
  has_many :projects
  validate :must_have_a_role, on: :update

  extend FriendlyId
  friendly_id :name, use: :slugged
  rolify

  after_create :assign_default_role

  def assign_default_role
    if User.count == 1
      self.add_role(:admin) if self.roles.blank?
      self.add_role(:moderator)
      self.add_role(:user)
    else
      self.add_role(:user) if self.roles.blank?
    end
  end

  private
    def must_have_a_role
      unless roles.any?
        errors.add(:roles, "must have at least one role")
      end
    end
end
