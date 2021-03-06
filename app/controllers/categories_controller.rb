class CategoriesController < ApplicationController
	before_action :get_categories, only: :index
	before_action :get_category, only: [ :edit, :update, :show ]
	before_action :require_admin_user, only: [:new, :create]
	
	def index
	end

	def new
		@category = Category.new
	end

	def show
		@category_articles = @category.articles.paginate(page: params[:page], per_page: 5)
	end

	def create
		@category = Category.create(category_params)
		if @category.save
			flash[:success] = "New category is added."
			redirect_to
		else
			flash[:danger] = @category.errors.full_messages
			render 'new'
		end
	end

	def edit
	end

	def update
		if @category.update(category_params)
			flash[:success] = "Category name is updated."
			redirect_to category_path(@category)
		else
			render 'edit'
		end
	end

	private
	def category_params
		params.require(:category).permit(:name)
	end

	def get_category
		@category = Category.find(params[:id])
	end

	def get_categories
		@categories = Category.paginate(:page => params[:page], :per_page => 5)
	end


end