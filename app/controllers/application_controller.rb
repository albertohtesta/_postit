class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?

  def current_user
  		# memoization
    @current_user ||= User.find_by_id(session[:user_id])
  end

   def logged_in?
     current_user != nil
   end

   def require_user
   	if !logged_in?
   		flash[:error]=' Debe estar logeado, para hacer eso!'
   		redirect_to root_path
   	end
   end
   def require_admin
    access_denied unless logged_in? and current_user.admin?
   end

  def access_denied
    flash[:error] = 'No tiene permisos para esta accion!'
    redirect_to root_path
  end

end