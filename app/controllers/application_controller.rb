# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery :secret => '97e134ffd267242077242d942498c790', :except => :update_cart
  
  private
  def redirect_to_index(msg = nil, level = 1)
    if msg
      case level
      when 1
        flash[:notice] = msg
      when 2
        flash[:warning] = msg
      when 3
        flash[:error] = msg
      when 4
        flash[:fatal] = msg
      end
    end
    redirect_to root_url
  end
   
  def authorize 
    unless User.find_by_id(session[:user_id])
      session[:request_uri] = request.request_uri
      redirect_to :controller => "login"
    end 
  end
end
