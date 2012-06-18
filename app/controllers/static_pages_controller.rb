# encoding: utf-8
class StaticPagesController < ApplicationController

  before_filter :signed_in_user, only: [:home]
  
  def home
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

  def help
  end
  
  def contact
  end
  
  private
    
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_path, notice: "Kirjaudu sisään kiitos."
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end  
end
