class Guest < ActiveRecord::Base
  has_one :login
  has_many :guest_menu_items
  has_many :menu_items, through: :guest_menu_items
end
