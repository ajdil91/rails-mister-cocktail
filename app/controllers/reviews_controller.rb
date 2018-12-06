class ReviewsController < ApplicationController
  skip_before_action :authenticate_user!
  skip_after_action :verify_authorized

  def new
    @cocktail = Cocktail.find(params[:cocktail_id])
    @review = Review.new
  end

  def create
    @cocktail = Cocktail.find(params[:cocktail_id])
    @review = Review.new(review_params)
    @review.cocktail = @cocktail
    if @review.save!
      respond_to do |format|
        format.html { redirect_to cocktail_path(@review.cocktail) }
        format.js
      end
    else
      flash[:notice] = "Unable to save"
      respond_to do |format|
        format.html { render "cocktails/show" }
        format.js
      end
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :content)
  end
end
