class GuestsController < ApplicationController

  def update_guest
    errors = []
    data = {}
    status = 200

    current_login = SessionHelper.is_logged_in(session, request.env['HTTP_USER_AGENT'])
    guest_id = params['guest_id'].to_i

    guest = Guest.find(guest_id)

    if guest.nil?
      status = 404
      errors << 'Guest not found'
    elsif params['rspv'].nil?
      status = 400
      errors << 'Bad Request'
    elsif current_login.nil?
      status = 403
      errors << 'Not authenticated to alter guest'
    elsif (current_login.guests.map { |guest| guest.id }).include?(guest_id)
      guest.rspv = params['rspv']
      guest.save

      data[:guest] = GuestHelper.serialize_guest(guest)
    else
      status = 400
      errors << 'Bad Request'
    end

    render plain: ApiHelper.render_response(errors, data), status: status
  end

end
