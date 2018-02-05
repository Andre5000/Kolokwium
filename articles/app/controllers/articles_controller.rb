class ArticlesController < ApplicationController
	#wyswietla artykuly po id rosnaco
	def index
		articles = Article.order('id');
		render json: {status: 'SUCCESS', message: 'Loaded articles', data:articles}, status: :ok
	end

	#wyswietla artykul po wprowadzeniu id
	def show
		article = Article.find(params[:id])
		render json: {status: 'SUCCESS', message: 'Loaded article', data:article}, status: :ok
	end

	#tworzy nowy artykul
	def create
		article = Article.new(article_params)

		if article.save
			render json: {status: 'SUCCESS', message: 'Saved article', data:article}, status: :ok
			else
			render json: {status: 'ERROR', message: 'Article not saved', data:article.errors}, status: :unprocessable_entity
			
		end	
	end

	#usuwa artykul po id
	def destroy
		article = Article.find(params[:id])
		article.destroy
		render json: {status: 'SUCCESS', message: 'Deleted article', data:article}, status: :ok
	end

	#aktualizuje arykul po id
	def update
		article = Article.find(params[:id])
			if article.update_attributes(article_params)
				render json: {status: 'SUCCESS', message: 'Updated article', data:article}, status: :ok
				else
				render json: {status: 'ERROR', message: 'Article not updated', data:article.errors}, status: :ok
				
			end
	end

	#parametry
	private
	def article_params
		params.permit(:title, :body)
	end		
end