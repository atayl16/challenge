class Project < ApplicationRecord
  belongs_to:user
  has_rich_text :content
  validates :name,  presence: true

  extend FriendlyId
  friendly_id :name, use: :slugged

  def to_s
    title
  end
end
