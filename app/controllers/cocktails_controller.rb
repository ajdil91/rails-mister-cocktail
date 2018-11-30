class CocktailsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  def index
    @cocktails = policy_scope(Cocktail).order(created_at: :desc)
    if params[:query].present?
      @cocktails = Cocktail.where("name ILIKE ?", "%#{params[:query]}%")
    else
      @cocktails = Cocktail.all
    end
  end

  def show
    @cocktail = Cocktail.find(params[:id])

    if current_user.id == @cocktail.user_id
      authorize @cocktail
      @review = Review.new
    else
      @review = Review.new
    end
  end

  def new
    @cocktail = Cocktail.new
    authorize @cocktail
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    @cocktail.user = current_user
    authorize @cocktail
    if @cocktail.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

  def destroy
    @cocktail = Cocktail.find(params[:id])
    authorize @cocktail
    @cocktail.destroy
    redirect_to cocktails_path
  end

  private

  def cocktail_params
      params.require(:cocktail).permit(:name, :photo)
  end
end
