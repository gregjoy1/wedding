class MenuItemsController < ApplicationController

  def get_all_menu_items
    errors = []
    data = {}
    status = 200

    if SessionHelper.is_logged_in(session, request.env['HTTP_USER_AGENT']).nil?
      status = 403
      errors << 'Not authenticated to view menu items'
    else
      data[:menu_items] = MenuItemHelper.sort_into_types(MenuItem.all)
    end

    render plain: ApiHelper.render_response(errors, data), status: status
  end

end

