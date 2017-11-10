Rails.application.routes.draw do
  devise_for :users
  root 'meetup#index'
end
