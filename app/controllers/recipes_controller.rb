# encoding: utf-8
class RecipesController < ApplicationController
  before_filter :signed_in_user
  before_filter :firm_admin
  before_filter :admin_user, only: []

  def index
    list = []
    @bakery.recipes.each { |e| list.push e.id }
    @recipes = @bakery.recipes.paginate(:page => params[:page], :per_page => 10).order('name')
  end
  
  def show
    @hasmaterials = @recipe.hasmaterials
    @subrecipe_sum_amount = @recipe.subrecipes_sum
    @bakery = @recipe.bakery
  end
  
  def new
    @recipe = Recipe.new
  end
  
  def create
    @recipe = Recipe.new(params[:recipe])
    @recipe.bakery = @bakery
    
    if @recipe.save
      
      if params[:new_recipes]
        params[:new_recipes].each do |recipe|
          Hasrecipe.create(:subrecipe_id => recipe[0], :recipe_id => @recipe.id, :amount => recipe[1])      
        end
      end
      
      if params[:new_materials]
        params[:new_materials].each do |material|
          Hasmaterial.create(:material_id => material[0], :recipe_id => @recipe.id, :amount => material[1])      
        end
      end
      
      flash[:success] = "Uusi resepti luotu!"
      redirect_to @recipe
    else
      render 'new'
    end
  end
  
  def edit
    # make so that only safe choices are shown
    @bakery.recipes.each do |r|
      @safe_recipes.push(r) unless r.has_circular? @recipe.name
    end
  end
  
  def update
    
    if params[:new_recipes]
      add_recipes
    end
    
    if params[:new_materials]
      add_materials
    end
    
    if @recipe.update_attributes(params[:recipe])
      save_recipe
    else
      flash.now[:error] = "Reseptin tallennus ei onnistunut."
      render 'edit'
    end
    
  end
  
  def destroy
    Hasrecipe.destroy_all(:recipe_id => @recipe.id)
    Hasrecipe.destroy_all(:subrecipe_id => @recipe.id)
    @recipe.destroy
    flash[:success] = "Resepti poistettu."
    redirect_to @bakery
  end
  
  private
    
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_path, notice: "Kirjaudu sisään kiitos."
      end
    end
    
    def firm_admin
      @safe_recipes = []
      @added_materials = []
      @added_recipes = []
      @tax = 0.13
      if params[:id]
        @recipe = Recipe.find(params[:id])
        @bakery = @recipe.bakery
      elsif params[:bakery_id]
        @bakery = Bakery.find_by_id(params[:bakery_id])
        if !@bakery
          @recipe = nil
        end
      end
      
      if @recipe and @recipe.bakery
        admins = @recipe.bakery.firm.users #later change to include only admins
      elsif @bakery
        admins = @bakery.firm.users #later change to include only admins
      else
        flash[:error] = "Ei lupaa tehdä muutoksia." 
        admins = []
      end
      redirect_to(root_path) unless admins.include? current_user
    end
    
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end  
    
    def save_recipe
      Hasrecipe.destroy_all(:recipe_id => @recipe.id)
      if params[:old_recipes]
        params[:old_recipes].each do |recipe|
          Hasrecipe.create(:subrecipe_id => recipe[0], :recipe_id => @recipe.id, :amount => recipe[1])
        end
      end
      
      if params[:new_recipes]
        params[:new_recipes].each do |recipe|
          Hasrecipe.create(:subrecipe_id => recipe[0], :recipe_id => @recipe.id, :amount => recipe[1])     
        end
      end
      
      Hasmaterial.destroy_all(:recipe_id => @recipe.id)
      if params[:old_materials]
        params[:old_materials].each do |material|
          Hasmaterial.create(:material_id => material[0], :recipe_id => @recipe.id, :amount => material[1])
        end
      end
      
      if params[:new_materials]
        params[:new_materials].each do |material|
          Hasmaterial.create(:material_id => material[0], :recipe_id => @recipe.id, :amount => material[1])     
        end
      end
      
      if @recipe.save
        flash[:success] = "Resepti tallennettu"
        redirect_to @recipe
      else
        flash.now[:error] = "Reseptin tallennus ei onnistunut."
        render 'edit'
      end
    end
    
    def add_materials
      params[:new_materials].each do |material|
        mat = Material.find(material[0])
        if mat
          @added_materials.push [mat, material[1]]   
        end
      end
    end
    
    def add_recipes
      params[:new_recipes].each do |recipe|
        res = Recipe.find(recipe[0])
        if res and not res.has_circular? @recipe.name
          @added_recipes.push [res, recipe[1]]   
        end
      end
    end
end
