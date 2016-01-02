module GuestHelper
  RSPV_UNKNOWN = 'unknown'
  RSPV_COMING = 'coming'
  RSPV_NOT_COMING = 'notcoming'

  def self.serialize_guest(guest)
    {
      :id => guest.id,
      :name => guest.name,
      :rspv => guest.rspv,
      :note => guest.note,
      :meal_choices => MenuItemHelper.sort_into_types(guest.menu_items)
    }
  end

end
