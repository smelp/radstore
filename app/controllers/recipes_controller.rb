# encoding: utf-8
class RecipesController < ApplicationController
  before_filter :signed_in_user
  before_filter :firm_admin
  before_filter :admin_user, only: []

  def show
    @firm = @recipe.firm
  end
  
  def new
    @recipe = Recipe.new
  end
  
  def create
    @recipe = Recipe.new(params[:recipe])
    @recipe.firm = @firm
    params[:materials].each do |material_id|
      mat = Material.find(material_id)
      @recipe.materials.push mat
    end
    
    if @recipe.save
      flash[:success] = "Uusi resepti luotu!"
      redirect_to @recipe
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    
    params[:materials].each do |material_id|
      mat = Material.find(material_id)
      @recipe.materials.push mat
    end
    
    if @recipe.update_attributes(params[:recipe])
      flash[:success] = "Resepti tallennettu"
      redirect_to @recipe
    else
      render 'edit'
    end
  end
  
  def destroy
    @recipe.destroy
    flash[:success] = "Resepti poistettu."
    redirect_to recipes_path
  end
  
  private
    
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_path, notice: "Kirjaudu sisään kiitos."
      end
    end
    
    def firm_admin
      if params[:id]
        @recipe = Recipe.find(params[:id])
      elsif params[:firm_id]
        @firm = Firm.find(params[:firm_id])
      end
      
      if @recipe and @recipe.firm
        admins = @recipe.firm.users #later change to include only admins
      elsif @firm
        admins = @firm.users #later change to include only admins
      else
        flash[:error] = "Ei lupaa tehdä muutoksia." 
        admins = []
      end
      redirect_to(root_path) unless admins.include? current_user
    end
    
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end  
end
