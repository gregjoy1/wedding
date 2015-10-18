class GuestMenuItem < ActiveRecord::Base
  belongs_to :guest
  belongs_to :menu_item
end

