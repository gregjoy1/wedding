class SessionController < ApplicationController

  def index
    error = []
    data = {}

    guest = SessionHelper.is_logged_in(session)

    if guest.nil?
      error = 'Not logged in'
    else
      data['guest'] = GuestHelper.serialize_guest(guest)
    end

    render plain: ApiHelper.render_response(error, data)
  end

  def login
    render plain: "login"
  end

  def logout
    render plain: "logout"
  end

end
