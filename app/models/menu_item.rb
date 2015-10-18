class MenuItem < ActiveRecord::Base
  has_many :guest_menu_items
  has_many :guests, through: :guest_menu_items
end

