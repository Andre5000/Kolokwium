class AuthorizeApiRequest 
	prepend SimpleCommand 
	#inicjalizuje header
	def initialize(headers = {}) 
		@headers = headers 
	end 

	#zwraca uzytkownika lub wystapi blad
	def call 
		user 
	end 

	private 
	attr_reader :headers 

	#sprawdza czy uzytkownik nie jest pusty i czy decoded_auth_token nie zwraca false
	def user 
		@user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token 
		@user || errors.add(:token, 'Invalid token') && nil 
	end 

	#odkodowuje token i pobiera id uzytkownika
	def decoded_auth_token 
		@decoded_auth_token ||= JsonWebToken.decode(http_auth_header) 
	end 

	#pobiera token z headera
	def http_auth_header 
		if headers['Authorization'].present? 
			return headers['Authorization'].split(' ').last 
		else 
			errors.add(:token, 'Missing token') 
		end 
		nil 
	end 
end
