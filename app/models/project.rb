class Project < ApplicationRecord
  belongs_to:user
  has_rich_text :content
  has_many :enrollments
  validates :name,  presence: true

  extend FriendlyId
  friendly_id :name, use: :slugged

  def joined(user)
    self.enrollments.where(user_id: [user.id], project_id: [self.id]).empty?
  end
end
