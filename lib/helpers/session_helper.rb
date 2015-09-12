module SessionHelper

  def self.login(session, password)
    guest = false

    password = HashHelper.password_hash(password)

    if (guest = Guest.where(:password => password).first).present?
      session[:user] = guest.id
    else
      logout(session)
    end
    guest
  end

  def self.logout(session)
    session[:user] = nil
  end

  def self.is_logged_in(session)
    if session[:user].present? && (guest = Guest.find(session[:user])).present?
     return guest
    end
    nil
  end

end
