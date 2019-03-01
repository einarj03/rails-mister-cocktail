class DosesController < ApplicationController
  def create
    @dose = Dose.new(dose_params)
    if @dose.save
      redirect_to cocktail_path(@dose.cocktail)
    else
      @cocktail = @dose.cocktail
      render :new
    end
  end

  def destroy
    @dose = Dose.find(params[:id])
    cocktail = @dose.cocktail
    @dose.destroy
    redirect_to cocktail_path(cocktail)
  end

  private

  def dose_params
    dose_params = params.require(:dose).permit(:description, :cocktail, :ingredient)
    dose_params[:ingredient] = Ingredient.find_by(name: dose_params[:ingredient])
    dose_params[:cocktail] = Cocktail.find(dose_params[:cocktail])
    return dose_params
  end
end
