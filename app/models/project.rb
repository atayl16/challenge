class Project < ApplicationRecord
  belongs_to :user, counter_cache: true
  has_rich_text :content
  has_many :enrollments
  validates :name,  presence: true
  has_many :comments, as: :commentable
  acts_as_votable

  extend FriendlyId
  friendly_id :name, use: :slugged

  scope :latest, -> { limit(3).order(created_at: :desc) }
  scope :best, -> { limit(3).order(average_rating: :desc, created_at: :desc) }
  scope :popular, -> { limit(3).order(enrollments_count: :desc, created_at: :desc) }

  def to_s
    name
  end

  def joined(user)
    self.enrollments.where(user_id: [user.id], project_id: [self.id]).empty?
  end

  def update_rating
    if enrollments.any? && enrollments.where.not(rating: nil).any?
      update_column :average_rating, (enrollments.average(:rating).round(2).to_f)
    else
      update_column :average_rating, (0)
    end
  end
end
