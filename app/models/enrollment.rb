class Enrollment < ApplicationRecord
  belongs_to :project
  belongs_to :user

  validates :user, :project, presence: true

  validates_uniqueness_of :user_id, scope: :project_id  #user cant be subscribed to the same project twice
  validates_uniqueness_of :project_id, scope: :user_id  #user cant be subscribed to the same project twice

  scope :pending_review, -> { where(rating: [0, nil, ""], review: [0, nil, ""]) }

  extend FriendlyId
  friendly_id :to_s, use: :slugged

  def to_s
    user.to_s + " " + project.to_s
  end

  after_save do
    unless rating.nil? || rating.zero?
      project.update_rating
    end
  end

  after_destroy do
    project.update_rating
  end

  protected


end
