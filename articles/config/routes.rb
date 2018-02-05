Rails.application.routes.draw do
 		resources :articles

   post 'authenticate', to: 'authentication#authenticate'
   put 'createuser', to: 'authentication#createuser'

end
 

