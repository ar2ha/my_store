MyStore::Application.routes.draw do
  devise_for :users
	
	root to: 'items#index'

	resources :items do
		get :upvote, on: :member
		get :expensive, on: :collection
	end

		get "admin/users_count" => "admin#users_count"
  # match ':controller(/:action(/:id))(.:format)'
end
