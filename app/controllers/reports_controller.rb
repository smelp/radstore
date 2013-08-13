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
    @start = params[:startDate]
    @end = params[:endDate]

    if params[:showArrivals]
      @arrivalEvents = Event.getArrivalsByDateRange(@start, @end)
    end
    if params[:showRemovals]
      @arrivalEvents = Event.getRemovalsByDateRange(@start, @end)
    end
    if params[:showCreated]
      @kitSums = sumsOfKits(@start, @end)
      kitIDs = @kitSums.map{|t| t.id}
      @kits = Batch.find_all_by_id(kitIDs)
    end
    if params[:showCreatedDetails]
      @arrivalEvents = Event.getArrivalsByDateRange(@start, @end)
    end
  end

  private

  def sumsOfKits (startTime, endTime)
    medIds = Radiomedicine.joins(:events).where("\"events\".\"event_type\" = 21 AND \"events\".\"user_timestamp\" BETWEEN '"+startTime.to_date.to_s+"' AND '"+endTime.to_date.to_s+"'").map{|med| med.id}
    kitSums = Haskit.select("\"kitID\" As id,COUNT(\"amount\") as amount").where(:productID => medIds).group("\"kitID\"")
  end

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
