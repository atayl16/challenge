class TagsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    # @tags = Tag.all.includes(:projects).where(projects: {approved: true, published: true}).order(project_tags_count: :desc) #tags for only published projects
    @tags = Tag.all.where.not(project_tags_count: 0).order(project_tags_count: :desc) # display only used tags
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      render json: @tag
    else
      render json: {errors: @tag.errors.full_messages}
    end
  end

  def destroy
    @tag = Tag.find(params[:id])
    authorize @tag
    @tag.destroy
    redirect_to tags_path, notice: "Tag was successfully destroyed"
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end
end
