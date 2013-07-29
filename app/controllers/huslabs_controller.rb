# encoding: utf-8
class HuslabsController < ApplicationController
  before_filter :signed_in_user
  before_filter :firm_admin
  before_filter :admin_user,     only: [:new, :create, :destroy]

  LN_2 = 0.69314718056
  E = 2.71828182845904523536028747135266249775724709369995

  def index
    if current_user.admin?
      @huslabs = Firm.paginate(page: params[:page], per_page:10)
    else
      sql = " SELECT *
      FROM firms AS f
      WHERE f.id IN (SELECT u.firm_id 
        FROM firms_users AS u 
        WHERE user_id='#{current_user.id}') AND f.resource_type='Huslab'"
      @huslabs = Firm.paginate_by_sql(sql, :page => params[:page])
    end
  end

  def show
    @huslab = Firm.find(params[:id]).resource
    @firm = Firm.find(params[:id])

    @substances = @huslab.substances.paginate(:page => params[:substance_page], :per_page => 20)
    @eluates = @huslab.eluates.paginate(:page => params[:eluate_page], :per_page => 20)
    @eluates.each do |eluate|
      timeElapsed = ((eluate.created - Time.now) / 3600).round
      eluate.radioactivity = calculateActivity eluate.radioactivity, eluate.volume, 5, 6
    end
    @radiomedicines = @huslab.radiomedicines.paginate(:page => params[:substance_page], :per_page => 20)
    # products = @huslab.recipes.where(:product => true)

    # if params[:search_recipe]
    #   q = params[:search_recipe]
    #   recipes = @bakery.recipes.paginate(:page => params[:recipe_page], :per_page => 20, :conditions => ['name like ? and product = ?', "%#{q.downcase}%", false]).order('name')
    #   @materials = @bakery.materials.paginate(:page => params[:page], :per_page => 20).order('name')
    # elsif params[:search_product]
    #   q = params[:search_product]
    #   products = @bakery.recipes.paginate(:page => params[:recipe_page], :per_page => 20, :conditions => ['name like ? and product = ?', "%#{q.downcase}%", true]).order('name')
    #   @materials = @bakery.materials.paginate(:page => params[:page], :per_page => 20).order('name')
    # elsif params[:search_material]
    #   q = params[:search_material]
    #   @materials = @bakery.materials.paginate(:page => params[:material_page], :per_page => 20, :conditions => ['name like ?', "%#{q.downcase}%"]).order('name')
    # else
    #   @materials = @bakery.materials.paginate(:page => params[:material_page], :per_page => 20).order('name')
    # end
    # @products = products.paginate(:page => params[:recipe_page], :per_page => 20).order('name')
    # @recipes = recipes.paginate(:page => params[:recipe_page], :per_page => 20).order('name')
    @users = @firm.users.paginate(:page => params[:page], :per_page => 5).order('name')
  end

  private
       
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_path, notice: "Kirjaudu sisään."
      end
    end
    
    def firm_admin
      @tax = 0.13
      if params[:id]
        @huslab = Firm.find(params[:id]).resource
        if @huslab and @huslab.firm 
          @firm = @huslab.firm
          admins = User.get_admins + @firm.users #later change to include only admins
        else
          flash[:error] = "Ei lupaa tehdä muutoksia." 
          admins = []
        end
      end
      redirect_to(root_path) unless admins.include? current_user
    end
    
    def admin_user
      if current_user
        redirect_to(root_path) unless current_user.admin?
      else
        redirect_to(root_path)
      end
    end

    def calculateActivity (activity, volume,elapsedTime,half_life)

      result = (activity/volume)*(E**(-elapsedTime*LN_2/half_life))
      puts activity.to_s+' '+volume.to_s+' '+elapsedTime.to_s+' '+half_life.to_s+' '+result.to_s
    end
end
