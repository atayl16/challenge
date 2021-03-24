class Tag < ApplicationRecord
  has_many :project_tags
  has_many :projects, through: :project_tags

	validates :name, length: {minimum: 1, maximum: 25}, uniqueness: true

end
