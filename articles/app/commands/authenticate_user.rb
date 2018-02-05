class AuthenticateUser 
	prepend SimpleCommand 
	#zbiera dane
	def initialize(email, password) 
		@email = email 
		@password = password 
	end 

	def call 
		JsonWebToken.encode(user_id: user.id) if user 
	end 

	private 

	attr_accessor :email, :password 

	#sprawdza czy uzytkownik istnieje w bazie danych jesli tak uzywa wbudowanej funkcij authenticate() w has_secure_password i zwraca uzytkownika 
	#jezeli nie zwraca nil
	def user 
		user = User.find_by_email(email) 
		return user if user && user.authenticate(password) 

		errors.add :user_authentication, 'invalid credentials' 
		nil 
	end 
end
