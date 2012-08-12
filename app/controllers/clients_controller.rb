# encoding: utf-8
class String
  def numeric?
    Float(self) != nil rescue false
  end
end

class ClientsController < ApplicationController
  before_filter :signed_in_user
  before_filter :firm_admin
  before_filter :admin_user, only: []
  
  def index
    list = []
    @firm.clients.each { |e| list.push e.id }
    @clients = @firm.clients.paginate(:page => params[:page]).order('name')
  end
  
  def show
    @client = Client.find(params[:id])
  end
  
  def new
    @client = Client.new
  end
  
  def create
    @client = Client.new(params[:client])
    @client.firm = @firm
    
    if @client.save
      flash[:success] = "Uusi asiakas luotu!"
      redirect_to @firm.resource
    else
      render 'new'
    end
  end
  
  def edit
    @clientrecipes = @client.clientrecipes
    @products = @firm.get_product_list
  end
  
  def update
    @clientrecipes = @client.clientrecipes
    @products = @firm.get_product_list
    if params[:new_product_prices]
      add_products
    end
  
    save_client
  end
  
  def destroy
    Clientrecipe.destroy_all(:client_id => @client.id)
    @client.destroy
    flash[:success] = "Asiakas poistettu."
    redirect_to @firm.resource
  end
  
  private
    
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_path, notice: "Kirjaudu sisään kiitos."
      end
    end
    
    def firm_admin
      @added_products = []
      # check that user has rights to show/modify client info 
      if params[:id]
        @client = Client.find(params[:id])
        @firm = @client.firm
      elsif params[:firm_id]
        @firm = Firm.find_by_id(params[:firm_id])
        if !@firm 
          @client = nil
          @firm = nil
        end
      end
      
      if @client and @client.firm
        admins = @client.firm.users #later change to include only admins
      elsif @firm
        admins = @firm.users #later change to include only admins
      else 
        admins = []
        flash[:error] = "Ei lupaa tehdä muutoksia."
      end
      redirect_to(root_path) unless admins.include? current_user
    end
    
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
    
    def add_products
      params[:new_product_prices].each do |product|
        res = Recipe.find(product[0])
        @added_products.push [res, product[1]]   
      end
    end
    
    def save_client
      Clientrecipe.destroy_all(:client_id => @client.id)
      if params[:old_product_prices]
        params[:old_product_prices].each do |product|
          temp_product = Recipe.find product[0]
          #total_amount += (recipe[1].to_f * temp_recipe.get_coveraged_price)
          
          if params[:changed_products] && params[:changed_products]["#{product[0]}"] != "" #if price has been manually changed, update its price
            if params[:changed_products]["#{product[0]}"].numeric?  
              Clientrecipe.create(:recipe_id => product[0], :client_id => @client.id, :price => params[:changed_products]["#{product[0]}"])
            else
              Clientrecipe.create(:recipe_id => product[0], :client_id => @client.id, :price => params[:old_product_prices]["#{product[0]}"])
              flash[:error] = "Kaikkia uusia hintoja ei voitu tallentaa oikein!"
            end
          else
            Clientrecipe.create(:recipe_id => product[0], :client_id => @client.id, :price => params[:old_product_prices]["#{product[0]}"])
          end
        
        end
      end
      
      if params[:new_product_prices]
        params[:new_product_prices].each do |product|
          temp_product = Recipe.find product[0]
          if Clientrecipe.find_by_recipe_id_and_client_id(product[0], @client.id)
            flash.now[:error] = "Et voi lisätä asiakkaalle uudelleen erikoishintaisia tuotteita, jotka on jo lisätty."
            render 'edit'
            return
          else
            Clientrecipe.create(:recipe_id => product[0], :client_id => @client.id, :price => temp_product.get_coveraged_price.round(2))    
          end
        end
      end
      
    
      if @client.update_attributes(params[:client])
        flash[:success] = "Asiakas tallennettu"
        redirect_to @client
      else
        flash[:error] = "Tallennus ei onnistunut."
        render 'edit'
      end
    end
end
