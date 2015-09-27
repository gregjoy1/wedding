class SessionController < ApplicationController

  def is_logged_in
    errors = []
    data = {}
    status = 200

    login = SessionHelper.is_logged_in(session, request.env['HTTP_USER_AGENT'])

    if login.nil?
      status = 403
      errors = 'Not logged in'
    else
      data['login'] = LoginHelper.serialize_login(login)
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
      if (login = SessionHelper.login(session, posted_password, request.env['HTTP_USER_AGENT'])).present?
        data = {
          :login => LoginHelper.serialize_login(login)
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
