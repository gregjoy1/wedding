Rails.application.routes.draw do

  scope '/api', { format: :json } do
    get 'session/' => 'session#is_logged_in'
    post 'session/login'
    get 'session/logout'

    put 'guests/:guest_id' => 'guests#update_guest'
    get 'menu_items/' => 'menu_items#get_all_menu_items'
  end

  root 'index#index'

end
