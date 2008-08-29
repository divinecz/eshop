# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def login
    if !session[:user_id].nil? && user = User.find_by_id(session[:user_id])
      [user.first_name, user.last_name].join(' ')+" | "+link_to("logout", :controller => "login", :action => 'logout')
    else
      link_to "login", :controller => "login"
    end
  end
  
  def currency(n)
    number_to_currency(n, :unit => "", :delimiter => " ", :precision => 0)+" Kč"
  end
end
