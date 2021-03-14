class Project < ApplicationRecord
  belongs_to:user
  has_rich_text :content
  validates :name,  presence: true


  def to_s
    title
  end
end
