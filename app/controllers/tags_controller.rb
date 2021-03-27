
class TagsController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:index]

  def index
    @tags = Tag.all.where.not(project_tags_count: 0).order(project_tags_count: :desc)
  end

  def create
    @tag = Tag.new(tag_params)
    @tag.name = @tag.name.titleize
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
