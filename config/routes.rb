Rails.application.routes.draw do
  devise_for :users
  root to: 'tops#top'
  get 'top/about' => 'tops#about'
  get "users/withdrawal" => "users#withdrawal"
  patch "users/withdrawal" => "users#withdrawal"

  resources :users,only: [:new, :show, :edit, :destroy, :update] do
  resource :relationships, only:[:create, :destroy]
    get 'follower' => 'relationships#follower', as: 'follower'
    get 'followed' => 'relationships#followed', as: 'followed'

  end
   resources :posts do
    resource :favorites, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end


  resources :post, only: [:new, :create, :index, :show, :edit, :destroy, :update] do
    resource :favorites, only: [:create, :destroy]
    resource :post_comments, only: [:create, :destroy]
    resource :relationship,only: [:create, :destroy, :followings, :followers]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
  get 'search' => 'searchs#search', as: 'search'

end