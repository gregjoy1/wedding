class SessionController < ApplicationController

  def is_logged_in
    errors = []
    data = {}
    status = 200

    guest = SessionHelper.is_logged_in(session)

    if guest.nil?
      status = 403
      errors = 'Not logged in'
    else
      data['guest'] = GuestHelper.serialize_guest(guest)
    end

    render plain: ApiHelper.render_response(errors, data), status: status
  end

  def login
    errors = []
    data = {}
    status = 200

    posted_password = JSON.parse(request.body.read)['password']

    if posted_password.nil?
      status = 400
      errors << 'Bad Request'
    else
      if (guest = SessionHelper.login(session, posted_password)).present?
        data = {
          :guest => GuestHelper.serialize_guest(guest)
        }
      else
        status = 403
        errors << 'Incorrect Password'
      end
    end

    render plain: ApiHelper.render_response(errors, data), status: status
  end

  def logout
    errors = []
    data = {}
    status = 200

    SessionHelper.logout(session)

    render plain: ApiHelper.render_response(errors, data), status: status
  end

end
