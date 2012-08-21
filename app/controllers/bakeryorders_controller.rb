# encoding: utf-8
require 'will_paginate/array'

class BakeryordersController < ApplicationController
  
  before_filter :signed_in_user
  before_filter :firm_admin
  before_filter :admin_user, only: []
  
  def index
    @bakeryorders = @bakery.bakeryorders.paginate(:page => params[:page])
  end
  
  def show
    @client_prices = @order.client.clientrecipes
    @bakeryorder = Bakeryorder.find(params[:id])
  end

  def new
    @order = Order.new
    @bakeryorder = Bakeryorder.new
    @products = []
    @bakery.recipes.each do |r|
      if r.product
        @products.push r
      end
    end
  end

  def create
    @products = []
    @bakery.recipes.each do |r|
      if r.product
        @products.push r
      end
    end
    @order = Order.new(params[:order])
    @bakeryorder = Bakeryorder.new(params[:bakeryorder])
    @bakeryorder.bakery = @bakery
    @bakeryorder.order = @order
        
    create_bakeryorder
  end

  def edit
    @client_prices = @order.client.clientrecipes
    @products = []
    @bakery.recipes.each do |r|
      if r.product
        @products.push r
      end
    end
  end
  
  def update
    @client_prices = @order.client.clientrecipes
    @products = []
    @bakery.recipes.each do |r|
      if r.product
        @products.push r
      end
    end
    
    if params[:new_recipes]
      add_recipes
    end
    
    if @bakeryorder.update_attributes(params[:bakeryorder]) 
      if @order.update_attributes(params[:order])
        save_bakeryorder
      else
        flash.now[:error] = "Tilauksen kaikkien tietojen tallentaminen ei onnistunut."
        render 'edit'
      end   
    else
      flash.now[:error] = "Tilauksen tallentaminen ei onnistunut."
      render 'edit'
    end
  end
  
  def destroy
    Bakeryorderrecipe.destroy_all(:bakeryorder_id => @bakeryorder.id)
    @bakeryorder.order.destroy
    @bakeryorder.destroy
    flash[:success] = "Tilaus poistettu."
    redirect_to :controller => "bakeryorders", :action => "index", :bakery_id => @bakery.id
  end


  private
    
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_path, notice: "Kirjaudu sisään kiitos."
      end
    end
    
    def firm_admin
      @types = Bakeryorder.get_delivery_types
      @states = Bakeryorder.get_state_list
      @added_recipes = []
      
      if params[:id]
        @bakeryorder = Bakeryorder.find(params[:id])
        @bakery = @bakeryorder.bakery
        #@bill = @bakeryorder.order.bill
        @order = @bakeryorder.order
        @clients = @bakery.firm.clients
      elsif params[:bakery_id]
        @bakery = Bakery.find_by_id(params[:bakery_id])
        @clients = @bakery.firm.clients
        if !@bakery 
          @bakeryorder = nil
          @bakery = nil
        end
      end
      
      if @bakeryorder and @bakeryorder.bakery
        admins = @bakeryorder.bakery.firm.users #later change to include only admins
      elsif @bakery
        admins = @bakery.firm.users #later change to include only admins
      else 
        admins = []
        flash[:error] = "Ei lupaa tehdä muutoksia."
      end
      redirect_to(root_path) unless admins.include? current_user
    end
    
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
    
    def add_recipes
      params[:new_recipes].each do |recipe|
        res = Recipe.find(recipe[0])
        @added_recipes.push [res, recipe[1]]   
      end
    end
    
    def create_bakeryorder
      if @bakeryorder.save
        if params[:new_recipes]
          total_amount = 0
          params[:new_recipes].each do |recipe|
            temp_recipe = Recipe.find(recipe[0])
            total_amount += (recipe[1].to_f * temp_recipe.get_coveraged_price)
            if @order.client
              clientrecipe = Clientrecipe.find_by_client_id_and_recipe_id(@order.client.id, recipe[0])
              if clientrecipe && params[:use_client_prices] == "yes"
                price = clientrecipe.price
              else
                price = temp_recipe.get_coveraged_price * recipe[1].to_f
              end
            else
              Bakeryorder.destroy @bakeryorder.id
              flash.now[:error] = "Tilauksen luominen ei onnistunut."
              render 'new'
              return
            end
            Bakeryorderrecipe.create(:recipe_id => recipe[0], :bakeryorder_id => @bakeryorder.id, :amount => recipe[1], :price => price)      
          end
        end
        
        if @order.save
          flash[:success] = "Uusi tilaus luotu!"
          redirect_to :controller => "bakeryorders", :action => "index", :bakery_id => @bakery.id
        else
          Bakeryorder.destroy @bakeryorder.id
          flash.now[:error] = "Tilauksen luominen ei onnistunut."
          render 'new'
        end  
      else
        flash.now[:error] = "Tilauksen luominen ei onnistunut."
        render 'new'
      end
    end
    
    def save_bakeryorder
      Bakeryorderrecipe.destroy_all(:bakeryorder_id => @bakeryorder.id)
      if params[:old_recipes_amounts]
        params[:old_recipes_amounts].each do |recipe|
          temp_recipe = Recipe.find recipe[0]
          #total_amount += (recipe[1].to_f * temp_recipe.get_coveraged_price)
          
          if params[:changed_recipes] && params[:changed_recipes]["#{recipe[0]}"] != ""  #if price has been manually changed, update its price
            Bakeryorderrecipe.create(:recipe_id => recipe[0], :bakeryorder_id => @bakeryorder.id, :amount => recipe[1], :price => params[:changed_recipes]["#{recipe[0]}"])
          else
            Bakeryorderrecipe.create(:recipe_id => recipe[0], :bakeryorder_id => @bakeryorder.id, :amount => recipe[1], :price => params[:old_recipes_prices]["#{recipe[0]}"])
          end
        
        end
      end
      
      if params[:new_recipes]
        params[:new_recipes].each do |recipe|
          temp_recipe = Recipe.find recipe[0]
          if Bakeryorderrecipe.find_by_recipe_id_and_bakeryorder_id(recipe[0], @bakeryorder.id)
            flash.now[:error] = "Et voi lisätä tilaukseen uudelleen reseptejä, jotka kuuluvat jo siihen."
            render 'edit'
            return
          else
            Bakeryorderrecipe.create(:recipe_id => recipe[0], :bakeryorder_id => @bakeryorder.id, :amount => recipe[1], :price => (temp_recipe.get_coveraged_price * recipe[1].to_f).round(2))     
          end
        end
      end
      
      if @bakeryorder.save && @order.save
        flash[:success] = "Tilaus tallennettu"
        redirect_to @bakeryorder
      else
        flash.now[:error] = "Tilauksen tallennus ei onnistunut."
        render 'edit'
      end
    end
end
