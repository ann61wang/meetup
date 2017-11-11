Rails.application.routes.draw do
  devise_for :users
  root 'meetups#index'
  resources :meetups do
    resources :comments
  end

  namespace :api, :defaults => { :format => :json } do
   namespace :v1 do
     get "/meetups" => "meetups#index", :as => :meetups

      post "/signup" => "auth#signup"
      post "/login" => "auth#login"
      post "/logout" => "auth#logout"
    end
  end
end
