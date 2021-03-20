class Projects::CommentsController < ApplicationController
  include Commentable
  before_action :set_commentable

  private
    def set_commentable
      @commentable = Project.friendly.find(params[:project_id])
    end
end
