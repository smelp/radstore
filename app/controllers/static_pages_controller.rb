# encoding: utf-8
class StaticPagesController < ApplicationController

  before_filter :signed_in_user, only: [:home]
  
  def home
    @email_us = "janne.laukkanen@pkhelppi.com"
    if current_user.admin?
      @firms = Firm.paginate(:page => params[:page], :per_page => 10)
    else
      sql = " SELECT *
      FROM firms AS f
      WHERE f.id IN (SELECT u.firm_id 
        FROM firms_users AS u 
        WHERE user_id='#{current_user.id}')"
      @firms = Firm.paginate_by_sql(sql, :page => params[:page], :per_page => 10)
    end
    redirect_to :controller => 'huslabs', :action => 'show', :id => 1
  end

  def help
  end
  
  def contact
  end
  
  private
    
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_path
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
