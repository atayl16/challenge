class Enrollment < ApplicationRecord
  belongs_to :project, counter_cache: true
  belongs_to :user, counter_cache: true

  validates :user, :project, presence: true

  validates_uniqueness_of :user_id, scope: :project_id  #user cant be subscribed to the same project twice
  validates_uniqueness_of :project_id, scope: :user_id  #user cant be subscribed to the same project twice

  scope :pending_review, -> { where(rating: [0, nil, ""], review: [0, nil, ""]) }
  scope :latest_good_reviews, -> { order(rating: :desc, created_at: :desc).limit(3) }
  scope :reviewed, -> { where.not(review: [0, nil, ""]) }
  scope :complete, -> { where(complete: true) }
  scope :incomplete, -> { where(complete: false) }

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
