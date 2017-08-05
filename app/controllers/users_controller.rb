class UsersController < ApplicationController
	before_action :find_user, only: [:edit, :show, :update, :destroy]

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			redirect_to articles_path
		else
			render 'new'
		end
	end

	def edit

	end	

	def update
		unless @user.update_attributes(user_params)
			render 'edit'
		end
	end

	def show
	end

	def destroy
		if @user.destroy
			redirect_to articles_path
		else
			render 'edit'
		end
	end



	private

	def user_params
		params.require(:user ).permit(:username, :email, :password)
	end

	def find_user
		@user = User.find(params[:id])
	end


end