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
		if @article.save
			redirect_to articles_path
		else
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
		@articles = Article.all
	end

	def get_article
		@article = Article.find(params[:id])
	end

	def set_article
		@article=  Article.new
	end



end
