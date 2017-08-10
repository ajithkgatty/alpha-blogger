class ArticlesController < ApplicationController
	before_action :get_articles, only: :index
	before_action :get_article, only: [:show, :update, :edit, :destroy]
	before_action :set_article, only: [:new]
	before_action :require_user, except: [:index, :show ]
	before_action :require_same_user, only: [:update, :edit, :destroy]

	def index
	end	

	def new
	end

	def create
		# render plain: params[:article].inspect
		@article = Article.new(article_params)
		@article.user_id = session[:user_id] if session[:user_id]
		if @article.save
			flash[:success] = "Article is successfully created."
			redirect_to articles_path
		else
			flash[:danger] = @article.errors.full_messages
			render 'new'
		end
	end	

	def show
		@article = Article.find(params[:id])
	end

	def edit
	end

	def update
		if @article.update_attributes(article_params)
			flash[:success] = "Article is successfully updated."
			redirect_to article_path(@article)
		else
			flash[:danger] = @article.errors.full_messages
			render 'form'
		end
	end

	def destroy
		if @article.destroy
			flash[:success] = "Article is successfully deleted"
			redirect_to articles_path
		else
			flash[:success] = "Something went wrong while deleting the article."
		end

	end

	private 
	def article_params
		params.require(:article).permit(:title, :description)
	end

	def get_articles
		@articles = Article.paginate(:page => params[:page], :per_page => 5)
	end

	def get_article
		@article = Article.find(params[:id])
	end

	def set_article
		@article=  Article.new
	end

	def require_same_user
  		if current_user != @article.user
  			flash[:danger] = "You can only edit/destroy articles created by you."
  			redirect_to root_path
  		end
  	end
end

