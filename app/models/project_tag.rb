class ProjectTag < ApplicationRecord
  belongs_to :project
  belongs_to :tag, counter_cache: true
end
