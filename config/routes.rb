Rails.application.routes.draw do
  mount Lists::API => '/'

  root to: 'static#home'
end
