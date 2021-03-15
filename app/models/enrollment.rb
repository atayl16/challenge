class Enrollment < ApplicationRecord
  belongs_to :project
  belongs_to :user

  validates :user, :project, presence: true

  validates_uniqueness_of :user_id, scope: :project_id  #user cant be subscribed to the same project twice
  validates_uniqueness_of :project_id, scope: :user_id  #user cant be subscribed to the same project twice


  protected


end
