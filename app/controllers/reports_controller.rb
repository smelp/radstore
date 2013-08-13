# encoding: utf-8
class ReportsController < ApplicationController
  before_filter :signed_in_user
  before_filter :firm_admin, only: [:index, :new, :create, :edit, :update, :destroy]
  before_filter :admin_user, only: []

  def new
  end

  def create
    redirect_to 'show'
  end

  def show
    if params[:showArrivals]
      @arrivalEvents = Event.getArrivalsByDateRange(params[:startDate], params[:endDate])
    end
    if params[:showRemovals]
      @arrivalEvents = Event.getRemovalsByDateRange(params[:startDate], params[:endDate])
    end
    if params[:showCreated]
      @radiomedEvents = Event.getRadiomedicinesByDateRange(params[:startDate], params[:endDate])
    end
    if params[:showCreatedDetails]
      @arrivalEvents = Event.getArrivalsByDateRange(params[:startDate], params[:endDate])
    end
  end

  private

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_path, notice: "Kirjaudu sisään kiitos."
    end
  end

  def firm_admin

    if params[:huslab_id]
      @huslab = Huslab.find_by_id(params[:huslab_id])
      if !@huslab
        @huslab = nil
      end
    end

    if @huslab
      admins = @huslab.firm.users #later change to include only admins
    else
      admins = []
      flash[:error] = 'Ei lupaa tehdä muutoksia.'
    end
    redirect_to(root_path) unless admins.include? current_user
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end


end
