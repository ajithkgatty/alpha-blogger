class UsersController < ApplicationController
	before_action :find_user, only: [:edit, :update, :destroy]
	before_action :require_user, except: [:show, :index, :new, :create]
	before_action :require_same_user, only: [:edit, :update]
	before_action :require_admin, only: [:destroy]

	def index
		@users = User.paginate(:page => params[:page], :per_page => 5)
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			flash[:success] = "User is succussfully created."
			redirect_to user_path @user
		else
			flash[:danger] = @user.errors.full_messages
			render 'new'
		end
	end

	def edit

	end	

	def update
		unless @user.update_attributes(user_params)
			flash.now[:danger] = "Something went wrong during updating the user."
			render 'edit'
		end
	end

	def show
		@user = User.find(params[:id])
		@user_articles =  @user.articles.paginate(:page => params[:page], :per_page => 5)
	end

	def destroy
		if @user.destroy
			redirect_to articles_path
			flash.now[:success] = "User is succussfully deleted."
		else
			flash[:danger] = "User is not deleted."
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

	def require_same_user
  		if current_user != @user
  			flash[:danger] = "You can only edit/update your profile."
  			redirect_to root_path
  		end
  	end 

  	def admin_user
  		if current_user != @user
  			flash[:danger] = "You can only edit/update your profile."
  			redirect_to root_path
  		end
  	end 

  	def require_admin
		if logged_in? and !current_user.admin?
			flash[:danger] = "Only admin users can perform that action"
			redirect_to root_path
		end
	end

	def can_delete_user?
		logged_in? && current_user.id == session[:user_id] ? true : false
	end
end