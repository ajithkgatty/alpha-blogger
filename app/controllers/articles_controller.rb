class ArticlesController < ApplicationController
	before_action :get_articles, only: :index
	before_action :get_article, only: [:show, :update, :edit, :destroy]
	before_action :set_article, only: [:new]

	def index
	end	

	def new
	end

	def create
		# render plain: params[:article].inspect
		@article = Article.new(article_params)
		@article.user_id = User.first.id
		if @article.save
			redirect_to articles_path
		else
			flash[:error_texts] = @article.errors.full_messages
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
			redirect_to article_path(@article)
		else
			flash[:error_texts] = @article.errors.full_messages
			render 'form'
		end
	end

	def destroy
		if @article.destroy
			redirect_to articles_path
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
end
