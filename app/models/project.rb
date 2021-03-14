class Project < ApplicationRecord
  has_rich_text :content
  validates :name,  presence: true
  validates :content, presence: true, length: { :minimum => 10 }

  
  def to_s
    title
  end
end
