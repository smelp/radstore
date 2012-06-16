# encoding: utf-8
class StaticPagesController < ApplicationController

  before_filter :signed_in_user, only: [:home]
  
  def home
    @firm = current_user.firms.first
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
