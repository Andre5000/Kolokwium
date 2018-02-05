class AuthenticationController < ApplicationController 
	skip_before_action :authenticate_request 


	#bierze parametry email i haslo Jsona prze hash parameters i wkleja je do AuthenticateUser
	#jezeli komenda zadziala wysle JWT token do uzytkownika
	def authenticate 
		command = AuthenticateUser.call(params[:email], params[:password]) 

		if command.success? 
			render json: { auth_token: command.result } 
		else 
			render json: { error: command.errors }, status: :unauthorized 
		end 
	end 

	#tworzy nowego uzytkownika	
	def createuser
		@user = User.new(user_params)
		if @user.save
	render json: @user, status: :created
		else
	render json: @user.errors, status: :unprocessable_entity
		end
	end


	#parametry
	def user_params
		params.permit(:name, :email, :password, :password_confirmation)
	end

end
