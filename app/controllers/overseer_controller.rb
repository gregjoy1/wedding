class OverseerController < ApplicationController

  def index 
    login = SessionHelper.is_logged_in(session, request.env['HTTP_USER_AGENT'])

    if login.nil? || !login.is_admin
      raise ActionController::RoutingError.new('Not Found')
    end

    @logins = Login.all
  end

end

