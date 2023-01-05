Rails.application.routes.draw do
  # root "articles#index"
  
  scope "/api", defaults: {format: :json} do
    post '/signup', to: 'authentication#signup'
    post '/login', to: 'authentication#login'
  
    post '/admin/products', to: 'admin/products#create'
    get '/products', to: 'products#index'

    get '/cart', to: 'cart#index'
    post '/cart/:product_id', to: 'cart#add_cart_item'
  end
end
