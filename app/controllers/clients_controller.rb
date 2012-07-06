# encoding: utf-8
class ClientsController < ApplicationController
  before_filter :signed_in_user
  before_filter :firm_admin, only: [:index, :new, :create, :edit, :update, :destroy]
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
  end
  
  def update
    if @client.update_attributes(params[:client])
      flash[:success] = "Asiakas tallennettu"
      redirect_to @client
    else
      render 'edit'
    end
  end
  
  def destroy
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
end
