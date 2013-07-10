# encoding: utf-8
class EluatesController < ApplicationController
  before_filter :signed_in_user
  before_filter :firm_admin, only: [:index, :new, :create, :edit, :update, :destroy]
  before_filter :admin_user, only: []

  def index
    list = []
    @huslab.eluates.each { |e| list.push e.id }
    @eluates = @huslab.eluates.paginate(:page => params[:page])
  end

  def show
    @eluate = Eluate.find(params[:id])
    @generators = @eluate.generators
    @others = @eluate.others
  end

  def new
    @eluate = Eluate.new
    @generators = Batch.joins(:substance).where('substances.substanceType' => Substance::GENERATOR)
    @others = Batch.joins(:substance).where('substances.substanceType' => Substance::OTHER)
    @event = Event.new
    @storagelocations = Storagelocation.all
  end

  def create
    @eluate = Eluate.new(params[:eluate])
    @eluate.huslab = @huslab

    if @eluate.save

      if params[:new_generators]
        params[:new_generators].each do |generator|
          batchToModify = Hasstoragelocation.find_by_item_id(generator[0])
          batchToModify.amount = batchToModify.amount - generator[1].to_f
          batchToModify.save
          Hasgenerator.create(:ownerType => Substance::ELUATE,:productID => @eluate.id, :generatorID => generator[0].to_f)
        end
      end

      if params[:new_others]
        params[:new_others].each do |other|
          batchToModify = Hasstoragelocation.find_by_item_id(other[0])
          batchToModify.amount -= other[1].to_f
          batchToModify.save
          Hasother.create(:ownerType => Substance::ELUATE,:productID => @eluate.id, :otherID => other[0].to_f)
        end
      end

      params[:new_storagelocations].each do |storage|
        Hasstoragelocation.create(:storagelocation_id => storage[0],:item_type => Substance::ELUATE, :item_id => @eluate.id, :amount => 1)
      end

      flash[:success] = "Uusi eluaatti luotu!"
      createEvent Event::NEW_ELUATE
      redirect_to @eluate
    else
        render 'new'
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

    if params[:id]
      @eluate = Eluate.find(params[:id])
      @huslab = @eluate.huslab
    elsif params[:huslab_id]
      @huslab = Huslab.find_by_id(params[:huslab_id])
      if !@huslab
        @eluate = nil
        @huslab = nil
      end
    end

    if @eluate and @eluate.huslab
      admins = @eluate.huslab.firm.users #later change to include only admins
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

  def createEvent( event )
    if event == Event::NEW_ELUATE
      Event.create(:target_id => @eluate.id, :event_type => event, :user_timestamp => params[:event][:user_timestamp], :signature => params[:event][:signature])
    elsif event == Event::MODIFY_ELUATE
      Event.create(:target_id => @eluate.id, :event_type => event, :user_timestamp => params[:event][:user_timestamp], :signature => params[:event][:signature])
    else

    end
  end

end
