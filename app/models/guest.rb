class Guest < ActiveRecord::Base
  has_one :login
end
