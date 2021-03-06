module LoginHelper

  def self.serialize_login(login, include_guests: true)
    returned_login = {
      :id => login.id,
      :name => login.name,
      :is_evening_guest => login.is_evening_guest
    }

    if include_guests
      returned_login[:guests] = login.guests.map { |guest| GuestHelper.serialize_guest(guest) }
    end

    returned_login
  end

end

