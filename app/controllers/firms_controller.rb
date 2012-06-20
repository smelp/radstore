# encoding: utf-8
class FirmsController < ApplicationController
  before_filter :signed_in_user
  #before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: [:new, :create, :destroy]

  def show
    @firm = Firm.find(params[:id])
    if current_user.admin?  
      if @firm.resource.class == Bakery
        @bakery = Bakery.find(params[:id])
      end
    else
      if @firm.resource.class == Bakery
        @bakery = Bakery.find(params[:id])
        @recipes = @firm.recipes
        @materials = @firm.materials
      end
    end
  end
  
  def index
    if current_user.admin?
      sql = " SELECT *
      FROM firms "
      # Could also be done like : Firm.paginate(:page: params[:page])
      @firms = Firm.paginate_by_sql(sql, :page => params[:page])
    else
      sql = " SELECT *
      FROM firms AS f
      WHERE f.id IN (SELECT u.firm_id 
        FROM firms_users AS u 
        WHERE user_id='#{current_user.id}')"
      @firms = Firm.paginate_by_sql(sql, :page => params[:page])
    end
  end
  
  def new
    @firm = Firm.new
    @bakery = Bakery.new
  end
  
  def create
    @firm = Firm.new(params[:firm])
    bakery = Bakery.new(params[:resource])
    @firm.attributes = params[:firm]
    @firm.resource = bakery
    
    if params[:users]
      params[:users].each do |user_id|
        user = User.find(user_id)
        @firm.users.push user
      end
    end
    
    if @firm.save
      flash[:success] = "Yritys onnistuneesti luotu"
      redirect_to firms_path
    else
      flash.now[:error] = params
      render 'new'
    end
  end
  
  def edit
    @firm = Firm.find(params[:id])
    @bakery = Bakery.find(params[:id])
  end
  
  def update
    @firm = Firm.find(params[:id])
    bakery = Bakery.find(params[:id])
    @firm.attributes = params[:firm]
    @firm.resource = bakery
    
    if params[:users]
      params[:users].each do |user_id|
        user = User.find(user_id)
        @firm.users.push user
      end
    end
    
    if @firm.save
      flash[:success] = "Yrityksen tiedot päivitetty"
      redirect_to @firm
    else
      render 'edit'
    end
  end
  
  def destroy
    Firm.find(params[:id]).destroy
    flash[:success] = "Yritys poistettu."
    redirect_to firms_path
  end
  
  private
    
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_path, notice: "Kirjaudu sisään."
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    
    def admin_user
      if current_user
        redirect_to(root_path) unless current_user.admin?
      else
        redirect_to(root_path)
      end
    end
end