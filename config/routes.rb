Rails.application.routes.draw do
	root 'homes#index'
	
	get '/wallet' => 'homes#create_wallet'
	get '/address' => 'homes#generate_address'
	get '/balance' => 'homes#check_balance'
	get '/random_address' => 'homes#random_address'
	get '/createaccount' => 'homes#create_account'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
