class EnrollmentsController < ApplicationController
  before_action :set_enrollment, only: %i[ show edit update destroy complete uncomplete ]
  before_action :set_project, only: [:new, :create]

  # GET /enrollments or /enrollments.json
  def index
    @ransack_path = enrollments_path
    @q = Enrollment.ransack(params[:q])
    @pagy, @enrollments = pagy(@q.result.includes(:user))
  end

  def incomplete
    @ransack_path = incomplete_enrollments_path
    @ransack_enrollments = Enrollment.incomplete.ransack(params[:enrollments_search], search_key: :enrollments_search)
    @pagy, @enrollments = pagy(@ransack_enrollments.result.includes(:user))
    render 'index'
  end

  def complete
    authorize @enrollment, :edit?
    @enrollment.update_attribute(:complete, true)
    redirect_to request.referrer, notice: "Congratulations on completing the challenge!"
  end

  def uncomplete
    authorize @enrollment, :edit?
    @enrollment.update_attribute(:complete, false)
    redirect_to request.referrer, notice: "Challenge marked as incomplete!"
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
    redirect_to project_path(@project), notice: "You accepted the challenge!"
  end

  # PATCH/PUT /enrollments/1 or /enrollments/1.json
  def update
    authorize @enrollment
    respond_to do |format|
      if @enrollment.update(enrollment_params)
        format.html { redirect_to @enrollment, notice: "Thank you for rating this challenge." }
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
      format.html { redirect_to request.referrer, notice: "You have left the challenge." }
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
      params.require(:enrollment).permit(:rating, :review, :complete)
    end
end
