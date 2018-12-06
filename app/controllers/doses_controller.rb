class DosesController < ApplicationController
skip_after_action :verify_authorized

  def new
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = Dose.new
  end

  def create
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = Dose.new(dose_params)
    @dose.cocktail = @cocktail
    if @dose.save
      redirect_to cocktail_path(@dose.cocktail)
    else
      @ingredients = remove_ingredient(@cocktail)
      render :new
    end
  end

  def destroy
    @dose = Dose.find(params[:id])
    @dose.destroy
    redirect_to cocktail_path(@dose.cocktail)
  end

  private

  def dose_params
    params.require(:dose).permit(:description, :ingredient_id)
  end

  def remove_ingredient(cocktail)
    ingredients = Ingredient.order(:name)
    cocktail.ingredients.each do |cocktail_ing|
      ingredients = ingredients.reject { |ingredient| ingredient == cocktail_ing }
    end
    ingredients
  end
end
