module SessionHelper

  def self.login(session, password, user_agent)
    login = false

    password = HashHelper.password_hash(password)

    if (login = Login.where(:password => password).first).present?
      session[:user] = login.id
      self.record_login(login, user_agent, true)
    else
      logout(session)
    end
    login
  end

  def self.record_login(login, user_agent, is_login = false)
      login_history = LoginHistory
                        .where("last_activity >= ?", Time.now.beginning_of_day)
                        .where("login_id = ?", login.id)
                        .order("last_activity")
                        .last

    if is_login || login_history.nil?
      login.login_historys << LoginHistory.create(
        :user_agent => user_agent,
        :logged_in => Time.now,
        :last_activity => Time.now
      )
    else
      login_history.last_activity = Time.now
      login_history.save
    end
  end

  def self.logout(session)
    session[:user] = nil
  end

  def self.is_logged_in(session, user_agent)
    begin
      if session[:user].present? && (login = Login.find(session[:user])).present?
        self.record_login(login, user_agent)
        return login
      end
      nil
    rescue => e
      nil
    end
  end

end
