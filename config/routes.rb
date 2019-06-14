Rails.application.routes.draw do
  get 'user/show'
  get 'auth/new'
  get 'auth/create'
  get 'auth/destroy'
  get 'auth/callback'

  root 'auth#new'
end
