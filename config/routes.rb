Rails.application.routes.draw do
  get '/:locale' => 'blog#index'

  scope '(:locale)', locale: /en|id/ do
    root 'blog#index'

    get '/register', to: 'auth#register_form', as: 'register_form'
    post '/register', to: 'auth#register', as: 'register'

    get '/login', to: 'auth#login_form', as: 'login_form'
    post '/login', to: 'auth#login', as: 'login'
    get '/logout', to: 'auth#logout', as: 'logout'
    get '/settings', to: 'account#settings', as: 'settings'

    get '/agreement', to: 'static#agreement', as: 'static_agreement'
    get '/privacy', to: 'static#privacy', as: 'static_privacy'

    get '/search', to: 'blog#search', as: 'blog_search'
    get '/article/:slug', to: 'blog#show', as: 'blog_show', slug: /[^\/]+/
    get '/category/:slug', to: 'blog#category', as: 'blog_category'
    get '/tag/:slug', to: 'blog#tag', as: 'blog_tag'
    get '/archive/:year/:month', to: 'blog#archive', as: 'blog_archive'
    get '/trending', to: 'blog#trending', as: 'blog_trending'

    get '/top_authors', to: 'author#top', as: 'top_authors'
    get '/author/:username', to: 'author#profile', as: 'profile', username: /[^\/]+/

    get '/contact', to: 'contact#form', as: 'contact'
    post '/contact/create', to: 'contact#create', as: 'contact_create'

    resources :articles do
      resources :comments
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
