class SessionController < ApplicationController

  def index
    render plain: "index"
  end

  def login
    render plain: "login"
  end

  def logout
    render plain: "logout"
  end

end
