# encoding: utf-8
class MaterialsController < ApplicationController
  before_filter :signed_in_user
  before_filter :firm_admin, only: [:index, :new, :create, :edit, :update, :destroy]
  before_filter :admin_user, only: []

  def index
    list = []
    @bakery.materials.each { |e| list.push e.id }
    @materials = @bakery.materials.paginate(:page => params[:page]).order('name')
  end

  def show
    @tax = 0.13
    @material = Material.find(params[:id])
  end
  
  def new
    @material = Material.new
  end
  
  def create
    @material = Material.new(params[:material])
    @material.bakery = @bakery
    
    if @material.save
      @material.recipes.each { |r| r.save }
      flash[:success] = "Uusi raaka-aine luotu!"
      redirect_to @bakery
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @material.update_attributes(params[:material])
      @material.recipes.each { |r| r.save }
      flash[:success] = "Raaka-aine tallennettu"
      redirect_to @material
    else
      render 'edit'
    end
  end
  
  def destroy
    @material.destroy
    Recipe.all.each { |r| r.save; r.reload }
    flash[:success] = "Raaka-aine poistettu."
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
      @tax = 0.13
      
      if params[:id]
        @material = Material.find(params[:id])
        @bakery = @material.bakery
      elsif params[:bakery_id]
        @bakery = Bakery.find_by_id(params[:bakery_id])
        if !@bakery 
          @material = nil
          @bakery = nil
        end
      end
      
      if @material and @material.bakery
        admins = @material.bakery.firm.users #later change to include only admins
      elsif @bakery
        admins = @bakery.firm.users #later change to include only admins
      else 
        admins = []
        flash[:error] = "Ei lupaa tehdä muutoksia."
      end
      redirect_to(root_path) unless admins.include? current_user
    end
    
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end  
end
