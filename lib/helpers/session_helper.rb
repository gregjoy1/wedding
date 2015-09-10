module SessionHelper

  def self.login(password)
    guest = false
    if (guest = Guest.where(:password => password)).present?
      session[:user] = guest.id
    else
      logout
    end
    guest
  end

  def self.logout
    session[:user] = nil
  end

  def self.is_logged_in(session)
    if session[:user].present? && (guest = Guest.find(session[:user])).present?
     return guest
    end
    nil
  end

end
