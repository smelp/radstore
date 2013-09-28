# encoding: utf-8
class RadiomedicinesController < ApplicationController
  before_filter :signed_in_user
  before_filter :firm_admin, only: [:index, :new, :create, :edit, :update, :destroy]
  before_filter :admin_user, only: []

  def index
    list = []
    @huslab.radiomedicines.each { |e| list.push e.id }
    @radiomedicines = @huslab.radiomedicines.paginate(:page => params[:page])
  end

  def show
    @radiomedicine = Radiomedicine.find(params[:id])
    @batches = Batch.find_by_sql('SELECT "batches".* FROM "batches" INNER JOIN "hasothers" ON "batches"."id" = "hasothers"."otherID" WHERE "hasothers"."ownerType" = \'Radiolääke\' AND "hasothers"."productID" = '+@radiomedicine.id.to_s)
    @batches += @radiomedicine.kits
    @eluate = @radiomedicine.eluate
  end

  def new
    @radiomedicine = Radiomedicine.new
    @others = Hasstoragelocation.joins(:batch).where("\"batches\".\"qualityControl\" != 6 AND \"hasstoragelocations\".\"batchType\" = 'Muu' AND \"hasstoragelocations\".\"amount\" > 0 ")
    @kits = Hasstoragelocation.joins(:batch).where("\"batches\".\"qualityControl\" != 6 AND \"hasstoragelocations\".\"batchType\" = 'Kitti' AND \"hasstoragelocations\".\"amount\" > 0 ")
    @event = Event.new
    @eluates = Eluate.todays
    @storagelocations = Storagelocation.all
  end

  def create
    @radiomedicine = Radiomedicine.new(params[:radiomedicine])
    @radiomedicine.huslab = @huslab

    if @radiomedicine.save

      if params[:new_others]
        params[:new_others].each do |other|
          storageLocation = Hasstoragelocation.find_by_id(other[0].to_f)
          Hasother.create(:ownerType => Substance::RADIOMEDICINE,:productID => @radiomedicine.id, :otherID => storageLocation.batch_id, :amount => 1)
        end
      end



      if params[:new_kits]
        params[:new_kits].each do |kit|
          storageLocation = Hasstoragelocation.find_by_id(kit[0])
          storageLocation.amount -= 1
          Haskit.create(:ownerType => Substance::RADIOMEDICINE,:productID => @radiomedicine.id, :kitID => storageLocation.batch_id, :amount => 1)
          batchToModify.save
        end
      end

      createEvent Event::NEW_RADIOMEDICINE
      flash[:success] = "Uusi radiolääke luotu!"
      redirect_to @radiomedicine
    else
      redirect_to :action => "new"
    end
  end

  def edit
    @storagelocations = Storagelocation.all
  end

  def update
    if @radiomedicine.update_attributes(params[:radiomedicine])
      flash[:success] = 'Radiolääkkeen '+@radiomedicine.name+' tiedot päivitetty'
      redirect_to @radiomedicine

    else
      flash[:error] = 'Erän '+@radiomedicine.name+' tietoja ei voitu päivittää'
    end
  end

  def destroy

    kitsToReturn = Haskit.find_all_by_ownerType_and_productID(Substance::RADIOMEDICINE, @radiomedicine.id)

    kitsToReturn.each do |kit|
      tempRow = Hasstoragelocation.find_by_batch_id(kit.kitID)
      tempRow.amount += kit.amount
      tempRow.save
    end

    Haskit.destroy_all(:ownerType => Substance::RADIOMEDICINE, :productID => @radiomedicine.id)
    Hasother.destroy_all(:ownerType => Substance::RADIOMEDICINE, :productID => @radiomedicine.id)

    Event.destroy_all(:event_type => Event::NEW_RADIOMEDICINE, :target_id => @radiomedicine.id)
    Event.create(:target_id => @radiomedicine.id, :user_timestamp => DateTime.now, :event_type => Event::RADIOMEDICINE_REMOVED, :signature => params[:signature])

    @radiomedicine.destroy

    #createEvent Event::RADIOMEDICINE_REMOVED

    flash[:success] = "Radioaktiivinen lääke poistettu."
    redirect_to @huslab
  end

  private

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_path, notice: "Kirjaudu sisään."
    end
  end

  def firm_admin

    if params[:id]
      @radiomedicine = Radiomedicine.find(params[:id])
      @huslab = @radiomedicine.huslab
    elsif params[:huslab_id]
      @huslab = Huslab.find_by_id(params[:huslab_id])
      if !@huslab
        @radiomedicine = nil
        @huslab = nil
      end
    end

    if @radiomedicine and @radiomedicine.huslab
      admins = @radiomedicine.huslab.firm.users #later change to include only admins
    elsif @huslab
      admins = @huslab.firm.users #later change to include only admins
    else
      admins = []
      flash[:error] = 'Ei lupaa tehdä muutoksia.'
    end
    #redirect_to(root_path) unless admins.include? current_user
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end

  def createEvent( event )
    if event == Event::NEW_RADIOMEDICINE
      Event.create(:target_id => @radiomedicine.id, :event_type => event, :user_timestamp => params[:event][:user_timestamp], :signature => params[:event][:signature])
    elsif event == Event::MODIFY_ELUATE
      Event.create(:target_id => @radiomedicine.id, :event_type => event, :user_timestamp => params[:event][:user_timestamp], :signature => params[:event][:signature])
    else

    end
  end

end

