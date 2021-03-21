class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
  has_many :projects
  has_many :enrollments
  validate :must_have_a_role, on: :update
  after_create :assign_default_role

  extend FriendlyId
  friendly_id :name, use: :slugged
  rolify


  def assign_default_role
    if User.count == 1
      self.add_role(:admin) if self.roles.blank?
      self.add_role(:moderator)
      self.add_role(:user)
    else
      self.add_role(:user) if self.roles.blank?
    end
  end

  def to_s
    email
  end

  def join_project(project)
    self.enrollments.create(project: project)
  end

  has_many :invitations
  has_many :pending_invitations, -> { where confirmed: false }, class_name: 'Invitation', foreign_key: "friend_id"

  def friends
    friends_i_sent_invitation = Invitation.where(user_id: id, confirmed: true).pluck(:friend_id)
    friends_i_got_invitation = Invitation.where(friend_id: id, confirmed: true).pluck(:user_id)
    ids = friends_i_sent_invitation + friends_i_got_invitation
    User.where(id: ids)
  end

  def friend_with?(user)
    Invitation.confirmed_record?(id, user.id)
  end

  def send_invitation(user)
    invitations.create(friend_id: user.id)
  end

  private
    def must_have_a_role
      unless roles.any?
        errors.add(:roles, "must have at least one role")
      end
    end
end
