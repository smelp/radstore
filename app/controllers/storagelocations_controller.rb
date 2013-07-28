# encoding: utf-8
class StoragelocationsController < ApplicationController
  before_filter :signed_in_user
  before_filter :firm_admin, only: [:index, :new, :create, :edit, :update, :destroy]
  before_filter :admin_user, only: []

  def index
    list = []
    @huslab.storagelocations.each { |e| list.push e.id }
    @storagelocations = @huslab.storagelocations.paginate(:page => params[:page]).order('name')
  end
  
  def show
    @storagelocation = Storagelocation.find(params[:id])
  end

  def new
    @storagelocation = Storagelocation.new
  end

  def create
    @storagelocation = Storagelocation.new(params[:storagelocation])
    @storagelocation.huslab = @huslab

    if @storagelocation.save
      flash[:success] = "Uusi varastopaikka luotu!"
      redirect_to @huslab
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @storagelocation.update_attributes(params[:storagelocation])
      @storagelocation.save
      flash[:success] = "Varaston '" + @storagelocation.name + "' tiedot päivitetty"
      redirect_to @storagelocation
    else
      flash[:error] = "Varaston '" + @storagelocation.name + "' tietoja ei voity päivittää"
    end
  end

  def destroy
    Hasstoragelocation.destroy_all(:storagelocation_id => @storagelocation.id)
    @storagelocation.destroy
    flash[:success] = "Varasto '" + @storagelocation.name + "' poistettu."
    redirect_to @huslab
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
        @storagelocation = Storagelocation.find(params[:id])
        @huslab = @storagelocation.huslab
      elsif params[:huslab_id]
        @huslab = Huslab.find_by_id(params[:huslab_id])
        if !@huslab
          @storagelocation = nil
          @huslab = nil
        end
      end

      if @storagelocation and @storagelocation.huslab
        admins = @storagelocation.huslab.firm.users #later change to include only admins
      elsif @huslab
        admins = @huslab.firm.users #later change to include only admins
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
