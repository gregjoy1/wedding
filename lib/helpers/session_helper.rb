module SessionHelper

  def login(password)
    guest = false
    if (guest = Guest.where(:password => password)).present?
      session[:user] = guest.id
    else
      logout
    end
    guest
  end

  def logout
    session[:user] = nil
  end

  def is_logged_in
    if session[:user].present? && (guest = Guest.find(session[:user])).present?
      guest
    end
    nil
  end

end
