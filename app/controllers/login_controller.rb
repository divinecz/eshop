class LoginController < ApplicationController

  def index
    session[:user_id] = nil
    if request.post?
      if user = User.authenticate(params[:email], params[:password])
        session[:user_id] = user.id
        
        uri = (session[:request_uri] || params[:return_uri])
        session[:request_uri] = nil
        redirect_to(uri || root_url)
      else
        flash[:notice] = "Invalid user/password combination"
      end
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to_index
  end
end
