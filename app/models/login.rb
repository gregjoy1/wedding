class Login < ActiveRecord::Base
  has_many :guests
  has_many :login_historys
end
