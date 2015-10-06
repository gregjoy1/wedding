Rails.application.routes.draw do

  scope '/api', { format: :json } do
    get 'session/' => 'session#is_logged_in'
    post 'session/login'
    get 'session/logout'

    put 'guests/:guest_id' => 'guests#update_guest'
  end

  root 'index#index'

end
