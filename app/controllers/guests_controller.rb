class GuestsController < ApplicationController

  def update_guest
    errors = []
    data = {}
    status = 200

    current_login = SessionHelper.is_logged_in(session, request.env['HTTP_USER_AGENT'])
    guest_id = params['guest_id'].to_i

    guest = Guest.find(guest_id)

    begin

      raise "404" if guest.nil?
      raise "403" if current_login.nil?
      raise "400" if !(current_login.guests.map { |guest| guest.id }).include?(guest_id)

      if params['menu_items'].present? and menu_item_error = MenuItemHelper.menu_item_request_invalid?(params['menu_items'])
        errors << menu_item_error
        raise "400"
      end

      guest.rspv = params['rspv'] if params['rspv'].present?
      guest.note = params['note'] if params['note'].present?

      if params['menu_items'].present?
        menu_items = params['menu_items'].map { |menu_item| menu_item[:id] }

        guest.menu_items = MenuItem.where(:id => menu_items)
      end

      guest.save

      data[:guest] = GuestHelper.serialize_guest(guest)

    rescue => error
      error_status = error.message

      errors << {
        "400" => 'Bad Request',
        "403" => 'Not authenticated to alter guest',
        "404" => 'Guest not found'
      }[error_status]

      errors = errors.reverse

      # If error is one of the above, use the error code, if not then throw 500
      status = (
        errors.count > 0 ?
        error_status.to_i :
        500
      )
    end

    render plain: ApiHelper.render_response(errors, data), status: status
  end

end
