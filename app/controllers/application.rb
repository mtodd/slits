class Application < Merb::Controller
  
  def current_user
    @current_user ||= User.get(session[:user_id])
  end
  
end
