class SessionsController < ApplicationController

	def new
		@user = User.new
	end

	def create
		user = User.find_by(email: params[:session][:email])
		if user && user.authenticate(params[:session][:password])
			session[:user_id] = user.id
			redirect_to user_path(user)
		else
			flash[:danger].now = "There was a problem in  loggin in !!!"
			render 'new'
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to root_path
	end

end