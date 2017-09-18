Rails.application.routes.draw do
  get 'blog/index'
  root 'blog#index'

  get '/article/:slug', to: 'blog#show', as: 'blog_show', slug: /[^\/]+/
  get '/category/:id', to: 'blog#category', as: 'blog_category'
  get '/tag/:id', to: 'blog#tag', as: 'blog_tag'
  get '/archive/:year/:month', to: 'blog#archive', as: 'blog_archive'

  resources :articles do
    resources :comments
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
