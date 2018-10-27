Rails.application.routes.draw do
	root 'homes#index'
	get '/address' => 'homes#generate_address'
	get '/balance' => 'homes#check_balance'
	# get '/createaccount' => 'homes#generate_account'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
