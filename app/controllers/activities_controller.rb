class ActivitiesController < ApplicationController
  before_action :set_activity, only: %i[ show edit update destroy ]
  before_action :build_activity_from_session, only: %i[ new edit create update ]
  before_action :save_activity, only: %i[ create update ]

  # GET /activities or /activities.json
  def index
    @activities = Activity.all
  end

  # GET /activities/1 or /activities/1.json
  def show
  end

  # GET /activities/new
  def new
  end

  # GET /activities/1/edit
  def edit
  end

  # POST /activities or /activities.json
  def create
    respond_to do |format|
      if @saved
        session[:activity_step] = session[:activity_params] = nil
        flash[:notice] = "Activity was successfully saved."
        format.html { redirect_to activities_path, status: :created }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /activities/1 or /activities/1.json
  def update
    if @saved
      session[:activity_step] = session[:activity_params] = nil
      flash[:notice] = "Activity was successfully saved."
      redirect_to activities_path
    else
      render action: :edit
    end
  end

  # DELETE /activities/1 or /activities/1.json
  def destroy
    @activity.destroy

    respond_to do |format|
      format.html { redirect_to activities_url, notice: "Activity was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def build_activity_from_session
      session[:activity_params] ||= {}
      session[:activity_params].deep_merge!(activity_params) if params[:activity]
      if @activity
        @activity.assign_attributes(session[:activity_params])
      else
        @activity = Activity.new(session[:activity_params])
      end

      @activity.current_step = session[:activity_step]
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_activity
      @activity = Activity.find(params[:id])
    end

    def save_activity
      if @activity.valid?
        if params[:previous_button]
          @activity.previous_step
        elsif @activity.last_step?
          @activity.save if @activity.all_valid?
          @saved = true
        else
          @activity.next_step
        end
        session[:activity_step] = @activity.current_step
      end
    end

    # Only allow a list of trusted parameters through.
    def activity_params
      params.require(:activity).permit(:name, :address, :starts_at, :ends_at)
    end
end
