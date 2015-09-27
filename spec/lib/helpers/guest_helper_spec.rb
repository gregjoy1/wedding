require 'rails_helper'
require "#{Rails.root.join('lib')}/helpers/guest_helper.rb"

RSpec.describe SessionHelper do
  include GuestHelper

  before(:all) do
    @guest = Guest.create(
      :name => 'Test Guest',
      :rspv => GuestHelper::RSPV_COMING
    )
  end

  after(:all) do
    @guest.destroy!
  end

  context 'serialize_guest' do
    before(:all) do
      @serialize_guest_returned = GuestHelper.serialize_guest(@guest)
    end

    it('returns guest correctly') do
      expect(@serialize_guest_returned[:id]).to eql(@guest.id)
      expect(@serialize_guest_returned[:name]).to eql(@guest.name)
      expect(@serialize_guest_returned[:rspv]).to eql(@guest.rspv)
    end
  end
end

