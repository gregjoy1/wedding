class GuestsController < ApplicationController

  def update_guest
    errors = []
    data = {}
    status = 200

    current_login = SessionHelper.is_logged_in(session, request.env['HTTP_USER_AGENT'])
    guest_id = params['guest_id'].to_i

    guest = Guest.find(guest_id)

    begin

      raise 404 if guest.nil?
      raise 403 if current_login.nil?
      raise 400 if !(current_login.guests.map { |guest| guest.id }).include?(guest_id)
      raise 400 if menu_item_request_invalid?(params['menu_items'])

      guest.rspv = params['rspv'] if params['rspv'].present?
      guest.menu_items = MenuItem.where(:id => params['menu_items']) if params['menu_item'].present?

      guest.save

      data[:guest] = GuestHelper.serialize_guest(guest)

    rescue => error_status
      status error_status

      errors << {
        400 => 'Bad Request',
        403 => 'Not authenticated to alter guest',
        404 => 'Guest not found'
      }[error_status]
    end

    render plain: ApiHelper.render_response(errors, data), status: status
  end

end
