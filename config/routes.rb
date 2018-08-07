Geo::Application.routes.draw do
	resources :conversion

	root to: 'conversion#new'
end
