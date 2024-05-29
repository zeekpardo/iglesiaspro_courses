class ReviewsController < ApplicationController
    before_action :authenticate_user!
  
    def create
      @course = Course.find(params[:course_id])
      @review = @course.reviews.build(review_params)
      @review.user = current_user
  
      if @review.save
        redirect_to @course, notice: 'Review was successfully created.'
      else
        redirect_to @course, alert: 'Failed to create review.'
      end
    end
  
    private
  
    def review_params
      params.require(:review).permit(:rating, :review)
    end
  end
  