# encoding: utf-8
class BatchesController < ApplicationController

  before_filter :signed_in_user
  before_filter :firm_admin, only: [:index, :new, :create, :edit, :update, :destroy]
  before_filter :admin_user, only: []

  def index
    list = []
    @substance.batches { |e| list.push e.id }
    @batches = @substance.batches.paginate(:page => params[:page])
  end

  def show
    @batch = Batch.find(params[:id])
    @substance = @batch.substance
    @storagelocations = @batch.hasstoragelocations
  end

  def new
    @batch = Batch.new
    @event = Event.new
    @storagelocations = Storagelocation.all
  end

  def qualityCheck
    @batch = Batch.find_by_id(params[:id])

    if params[:result] == 'OK'
      @batch.qualityControl = Event::QUALITY_CHECK_OK
    else
      @batch.qualityControl = Event::QUALITY_CHECK_NOK
    end

    @batch.save

    Event.create(:target_id => @batch.id, :event_type => @batch.qualityControl, :signature => params[:signature])
    redirect_to :controller => 'substances', :action => 'show', :id => 1
  end

  def create
    determineBatchType
    @batch.substance = @substance
    @batchFound = Batch.find_by_batchNumber_and_substance_id(@batch.batchNumber, @substance.id)

    if !@batchFound
      if params[:new_storagelocations] and @batch.save and handleStorageLocations(@batch.id, @substance.substanceType)
        flash[:success] = "Uusi erä luotu!"
        createEvent Event::NEW_BATCH
        redirect_to @substance
      else
        flash.now[:error] = "Lähetys ei onnistunut"
        @event = Event.new
        @storagelocations = Storagelocation.all
        render 'new'
      end
    else
      if handleStorageLocations @batchFound.id, @substance.substanceType
        flash[:success] = "Lähetys lisätty erään!"
        createEvent Event::ADD_TO_BATCH
        redirect_to @substance
      else
        flash.now[:error] = "Lähetys ei onnistunut"
        @event = Event.new
        @storagelocations = Storagelocation.all
        render 'new'
      end
    end

  end

  def edit
    @event = Event.new
  end

  def update
    if @batch.update_attributes(params[:batch])
      flash[:success] = 'Erän '+@batch.batchNumber+' tiedot päivitetty'
      redirect_to @substance

    else
      flash[:error] = 'Erän '+@batch.genericName+' tietoja ei voitu päivittää'
    end
  end

  def destroy
    Hasstoragelocation.destroy_all(:batch_id => @batch.id)
    @batch.destroy
    flash[:success] = "Erä " + @batch.batchNumber + " poistettu."
    redirect_to @batch.substance
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
        @batch = Batch.find(params[:id])
        @substance = @batch.substance
      elsif params[:substance_id]
        @substance = Substance.find_by_id(params[:substance_id])
        if !@substance
          @substance = nil
          @batch = nil
        end
      end

      if @batch and @batch.substance.huslab
        admins = @substance.huslab.firm.users #later change to include only admins
      elsif @substance
        admins = @substance.huslab.firm.users #later change to include only admins
      else
        admins = []
        flash[:error] = 'Ei lupaa tehdä muutoksia.'
      end
      redirect_to(root_path) unless admins.include? current_user
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

    def determineBatchType

      if @substance.substanceType == 1

        @batch = Generator.new(params[:batch])

      elsif @substance.substanceType == 2

        @batch = Kit.new(params[:batch])

      else

        @batch = Other.new(params[:batch])

      end

    end

    def handleStorageLocations( batchID, substanceType )
      if params[:new_storagelocations]
        params[:new_storagelocations].each do |storage|
          existingStorage = Hasstoragelocation.find_by_storagelocation_id_and_batch_id(storage[0], batchID)

          if !existingStorage
            Hasstoragelocation.create(:storagelocation_id => storage[0], :batch_id => batchID, :amount => storage[1], :batchType => substanceType)
            true
          else
            existingStorage.amount += storage[1].to_f
            existingStorage.save
          end
        end
      else
        false
      end
    end

    def createEvent( eventType )
      params[:event].each do |event|
        Event.create(:target_id => @batch.id, :event_type => eventType, :user_timestamp => event[2], :signature => event[0], :info => event[1]+' ;'+@batch.amount.to_s+" arrived")
      end
    end

end

