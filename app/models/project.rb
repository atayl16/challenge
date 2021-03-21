class Project < ApplicationRecord
  belongs_to :user
  has_rich_text :content
  has_many :enrollments
  validates :name,  presence: true
  has_many :comments, as: :commentable
  
  extend FriendlyId
  friendly_id :name, use: :slugged

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
