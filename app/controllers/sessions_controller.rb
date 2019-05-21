class SessionsController < ApplicationController
	def new
	end

	def create
		user = User.where(username: params[:username]).first
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			flash[:notice] = 'Bienvenido! has entrado al sistema'
			redirect_to root_path
		else
			flash[:error]='Error en usuario/contraseña'
			redirect_to login_path
		end
	end

	def destroy
		session[:user_id] = nil
		flash[:notice] = 'Has cerrado la sesion'
		redirect_to root_path
	end

end