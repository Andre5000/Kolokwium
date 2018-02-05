class ApplicationController < ActionController::API 
	#wysyla zadanie o headera do AuthorizeApiRequest uzywajac (request.headers)
	before_action :authenticate_request 
	attr_reader :current_user 

	private 

	#result jest powiazane z attr_reader results
	#rezultaty zapytania sa zwracane do aktualnego uzytkownika
	def authenticate_request 
		@current_user = AuthorizeApiRequest.call(request.headers).result 
		render json: { error: 'Not Authorized' }, status: 401 unless @current_user 
	end 
end
