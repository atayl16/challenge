class EnrollmentsController < ApplicationController
  before_action :set_enrollment, only: %i[ show edit update destroy ]
  before_action :set_project, only: [:new, :create]

  # GET /enrollments or /enrollments.json
  def index
    @q = Enrollment.ransack(params[:q])
    @pagy, @enrollments = pagy(@q.result.includes(:user))
  end

  # GET /enrollments/1 or /enrollments/1.json
  def show
  end

  # GET /enrollments/new
  def new
    @enrollment = Enrollment.new
  end

  # GET /enrollments/1/edit
  def edit
  end

  # POST /enrollments or /enrollments.json
  def create
    @enrollment = current_user.join_project(@project)
    redirect_to project_path(@project), notice: "You are enrolled!"
  end

  # PATCH/PUT /enrollments/1 or /enrollments/1.json
  def update
    authorize @enrollment
    respond_to do |format|
      if @enrollment.update(enrollment_params)
        format.html { redirect_to @enrollment, notice: "Enrollment was successfully updated." }
        format.json { render :show, status: :ok, location: @enrollment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @enrollment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /enrollments/1 or /enrollments/1.json
  def destroy
    authorize @enrollment
    @enrollment.destroy
    respond_to do |format|
      format.html { redirect_to enrollments_url, notice: "Enrollment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_enrollment
      @enrollment = Enrollment.friendly.find(params[:id])
    end

    def set_project
      @project = Project.friendly.find(params[:project_id])
    end

    # Only allow a list of trusted parameters through.
    def enrollment_params
      params.require(:enrollment).permit(:rating, :review)
    end
end
