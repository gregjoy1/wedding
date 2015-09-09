Rails.application.routes.draw do

  scope '/api', { format: :json } do
    get 'session/index'
    post 'session/login'
    get 'session/logout'
  end

  root 'index#index'

end
