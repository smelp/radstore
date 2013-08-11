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
    @substances = Substance.all
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
    @substance = Substance.find_by_id(params[:batch][:substance_id])
    determineBatchType
    @batchFound = Batch.find_by_batchNumber_and_substance_id(@batch.batchNumber, @substance.id)

    if !@batchFound
      if params[:new_storagelocations] and @batch.save and handleStorageLocations(@batch.id, @substance.substanceType)
        flash[:success] = "Uusi erä luotu!"
        @event = Event.new(params[:event])
        @event.target_id = @batch.id
        @event.event_type = Event::NEW_BATCH
        @event.info = 'Saapui '+@batch.amount.to_s+' kpl, Kommentti: '+@event.info
        @event.save
        createEvent Event::STORAGE_COMMENT
        redirect_to @substance
      else
        flash.now[:error] = "Erän luonti ei onnistunut"
        @event = Event.new
        @storagelocations = Storagelocation.all
        render 'new'
      end
    else
      if handleStorageLocations @batchFound.id, @substance.substanceType
        @event = Event.new(params[:event])
        @event.target_id = @batchFound.id
        @event.event_type = Event::ADD_TO_BATCH
        @event.info = 'Saapui '+sumUp.to_s+' kpl, Kommentti: '+@event.info
        @event.save
        createEvent Event::ADD_TO_BATCH
        flash[:success] = "Lähetys lisätty erään!"
        redirect_to @substance
      else
        flash.now[:error] = "Lähetyksen lisäys ei onnistunut"
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
      flash[:error] = 'Erän '+@batch.generic_name+' tietoja ei voitu päivittää'
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
        @huslab = @batch.substance.huslab
      elsif params[:huslab_id]
        @huslab = Huslab.find_by_id(params[:huslab_id])
        if !@huslab
          @huslab = nil
          @batch = nil
        end
      end

      if @batch and @batch.substance.huslab
        admins = @batch.substance.huslab.firm.users #later change to include only admins
      elsif @huslab
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

    def determineBatchType

      if @substance.substanceType == Substance::GENERATOR

        @batch = Generator.new(params[:batch])

      elsif @substance.substanceType == Substance::KIT

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

    def sumUp
      sum = 0
      params[:new_storagelocations].each do |storage|
         sum += storage[1].to_f
      end
      sum
    end

    def createEvent( eventType )
      if eventType == Event::STORAGE_COMMENT
        Event.create(:target_id => @batch.id, :event_type => eventType, :user_timestamp => Date.today, :signature => 'SYSTEM', :info => '')
      end
    end

end

