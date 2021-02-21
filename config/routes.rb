Rails.application.routes.draw do
  devise_for :users
  root to: 'tops#top'
  get 'top/about' => 'tops#about'
  get "users/withdrawal" => "users#withdrawal"
  post '/tops/guest_sign_in', to: 'tops#new_guest'
  patch "users/withdrawal" => "users#withdrawal"
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
  

  resources :users,only: [:new, :index, :show, :edit, :destroy, :update] do
  resource :relationships, only:[:create, :destroy]
    get 'follower' => 'relationships#follower', as: 'follower'
    get 'followed' => 'relationships#followed', as: 'followed'
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'

  end
   resources :posts do
    resource :favorites, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end


  resources :post, only: [:new, :create, :index, :show, :edit, :destroy, :update] do
    resource :favorites, only: [:create, :destroy]
    resource :post_comments, only: [:create, :destroy]
    resource :relationship,only: [:create, :destroy, :followings, :followers]

  end

 post 'follow/:id' => 'relationships#follow', as: 'follow'
 delete 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'search' => 'search#search', as: 'search'

end
