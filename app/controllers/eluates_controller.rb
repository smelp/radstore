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
    @generators = Batch.joins(:substance).where('substances.substanceType' => 1)
    @others = Batch.joins(:substance).where('substances.substanceType' => 2)
    @event = Event.new
  end

  def create
    @eluate = Eluate.new(params[:eluate])
    @eluate.huslab = @huslab

    if @eluate.save

      if params[:new_generators]
        params[:new_generators].each do |generator|
          batchToModify = Batch.find_by_id(generator[0])
          batchToModify.amount = batchToModify.amount - generator[1].to_f
          batchToModify.save
          Hasgenerator.create(:ownerType => 1,:productID => @eluate.id, :generatorID => generator[0].to_f)
        end
      end

      if params[:new_others]
        params[:new_others].each do |other|
          batchToModify = Batch.find_by_id(other[0])
          batchToModify.amount -= other[1].to_f
          batchToModify.save
          Hasother.create(:ownerType => 1,:productID => @eluate.id, :otherID => other[0].to_f)
        end
      end
      flash[:success] = "Uusi eluaatti luotu!"
      Event.create(:target_id => @batch.id, :event_type => 20, :signature => params[:event][:signature])
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

end
