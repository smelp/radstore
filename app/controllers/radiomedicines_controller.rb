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
    @generators = @radiomedicine.generators
    @others = @radiomedicine.others
    @kits = @radiomedicine.kits
    @eluates = @radiomedicine.eluates
  end

  def new
    @radiomedicine = Radiomedicine.new
    @generators = Batch.joins(:substance).where('substances.substanceType' => 1)
    @others = Batch.joins(:substance).where('substances.substanceType' => 2)
    @kits = Batch.joins(:substance).where('substances.substanceType' => 3)
    @eluates = Eluate.all
  end

  def create
    @radiomedicine = Radiomedicine.new(params[:radiomedicine])
    @radiomedicine.huslab = @huslab

    if @radiomedicine.save

      if params[:new_others]
        params[:new_others].each do |other|
          batchToModify = Batch.find_by_id(other[0])
          batchToModify.amount -= other[1].to_f
          batchToModify.save
          Hasother.create(:ownerType => 2,:productID => @radiomedicine.id, :otherID => other[0].to_f)
        end
      end

      if params[:new_generators]
        params[:new_generators].each do |generator|
          batchToModify = Batch.find_by_id(generator[0])
          batchToModify.amount = batchToModify.amount - generator[1].to_f
          batchToModify.save
          Hasgenerator.create(:ownerType => 2,:productID => @radiomedicine.id, :generatorID => generator[0].to_f)
        end
      end



      if params[:new_kits]
        params[:new_kits].each do |kit|
          batchToModify = Batch.find_by_id(kit[0])
          batchToModify.amount -= kit[1].to_f
          batchToModify.save
          Haskit.create(:ownerType => 2,:productID => @radiomedicine.id, :kitID => kit[0].to_f)
        end
      end

      if params[:new_eluates]
        params[:new_eluates].each do |eluate|
          Haseluate.create(:radiomedicine_id => @radiomedicine.id, :eluate_id => eluate[0].to_f)
        end
      end

      flash[:success] = "Uusi radiolääke luotu!"
      redirect_to @radiomedicine
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
    redirect_to(root_path) unless admins.include? current_user
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end

end

