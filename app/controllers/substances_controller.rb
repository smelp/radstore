# encoding: utf-8
class SubstancesController < ApplicationController
  before_filter :signed_in_user
  before_filter :firm_admin, only: [:index, :new, :create, :edit, :update, :destroy]
  before_filter :admin_user, only: []

  def index
    list = []
    @huslab.substances.each { |e| list.push e.id }
    @substances = @huslab.substances.paginate(:page => params[:page])
  end

  def show
    @substance = Substance.find(params[:id])
    @batches = @substance.batches
  end

  def new
    @substance = Substance.new
  end

  def create
    @substance = Substance.new(params[:substance])
    @substance.huslab = @huslab
    @substance.substanceType = determineSubstanceType(params[:substance][:substanceType])
    if @substance.save
      flash[:success] = "Uusi raaka-aine luotu!"
      redirect_to @huslab
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if params[:substance][:substanceType] == Substance::KIT

    end
    if @substance.update_attributes(params[:substance])
      flash[:success] = 'Aineen '+@substance.genericName+' tiedot päivitetty'
      redirect_to @substance
    else
      flash[:error] = 'Aineen '+@substance.genericName+' tietoja ei voity päivittää'
    end
  end

  def destroy
    @substance.destroy
    flash[:success] = "Raaka-aine poistettu."
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
        @substance = Substance.find(params[:id])
        @huslab = @substance.huslab
      elsif params[:huslab_id]
        @huslab = Huslab.find_by_id(params[:huslab_id])
        if !@huslab
          @substance = nil
          @huslab = nil
        end
      end

      if @substance and @substance.huslab
        admins = @substance.huslab.firm.users #later change to include only admins
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

    def determineSubstanceType(type)
      if type == 'Generaattori'
        Substance::GENERATOR
      elsif type == 'Kitti'
        Substance::KIT
      else
        Substance::OTHER
      end
      
    end

end
