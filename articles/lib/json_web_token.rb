class JsonWebToken 
	class << self 
		#Sprawdza uzytkownika i generuje token
		def encode(payload, exp = 24.hours.from_now) 
			payload[:exp] = exp.to_i 
			JWT.encode(payload, Rails.application.secrets.secret_key_base) 
		end 


		#Sprawdza czy token jest poprawny przy kazdym zapytaniu
		def decode(token) 
			body = JWT.decode(token, Rails.application.secrets.secret_key_base)[0] 
			HashWithIndifferentAccess.new body 
		rescue 
			nil 
		end 
	end 
end
