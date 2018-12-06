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
      redirect_to cocktail_path(@review.cocktail)
    else
      flash[:notice] = "Unable to save"
      render "cocktails/show"
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :content)
  end
end
