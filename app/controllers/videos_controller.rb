class VideosController < ApplicationController
  before_action :set_course
  before_action :set_video, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :authorize_admin!, only: [:index, :new, :create, :edit, :update, :destroy]


  # GET /videos or /videos.json
  def index
    @videos = @course.videos
  end

  # GET /videos/1 or /videos/1.json
  def show
    @videos = @course.videos.order(:id) # List of all videos in the course
  end

  # GET /videos/new
  def new
    @video = @course.videos.new
  end

  # GET /videos/1/edit
  def edit
    @video = Video.find(params[:id])
  end

  # POST /videos or /videos.json
  def create
    @video = @course.videos.build(video_params)
    Rails.logger.debug { "Video params: #{video_params.inspect}" }

      if @video.save
        redirect_to course_videos_url(@course), notice: "Video was successfully created." 
      else
       render :new, status: :unprocessable_entity 
      end
  end

  # PATCH/PUT /videos/1 or /videos/1.json
  def update
    respond_to do |format|
      if @video.update(video_params)
        format.html { redirect_to course_video_url(@course, @video), notice: "Video was successfully updated." }
        format.json { render :show, status: :ok, location: course_video_url(@course, @video) }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1 or /videos/1.json
  def destroy
    @video = Video.find(params[:id])
    @video.destroy!

    respond_to do |format|
      format.html { redirect_to videos_url, notice: "Video was successfully destroyed." }
      format.json { head :no_content }
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
       @video = Video.find(params[:id])
    end

    def set_course
      @course = Course.find_by!(slug: params[:course_id])
    end

    # Only allow a list of trusted parameters through.
    def video_params
      params.require(:video).permit(:name, :description, :youtube_id, :call_to_action, :resource, :course_id)
    end

    def authorize_admin!
      redirect_to root_path, alert: 'You are not authorized to perform this action.' unless current_user.admin?
    end
end
