require 'rails_helper'
require "#{Rails.root.join('lib')}/helpers/guest_helper.rb"

RSpec.describe GuestHelper do
  include GuestHelper

  before(:each) do
    @guest = Guest.create(
      :name => 'Test Guest',
      :rspv => GuestHelper::RSPV_COMING
    )

    [
      ["Test Starter One","Test Starter One Description","V","starter"],
      ["Test Main Three","Test Main Three Description","V","main"],
      ["Test Desert Four","Test Desert Four Description","","desert"]
    ].each do |menu_item|
      @guest.menu_items << MenuItem.create(
        name: menu_item[0],
        description: menu_item[1],
        labels: menu_item[2],
        meal_type: menu_item[3]
      )
    end

    @guest.save
  end

  after(:each) do
    @guest.destroy!
  end

  context 'serialize_guest' do
    before(:each) do
      @serialize_guest_returned = GuestHelper.serialize_guest(@guest)
    end

    it('returns guest correctly') do
      expect(@serialize_guest_returned[:id]).to eql(@guest.id)
      expect(@serialize_guest_returned[:name]).to eql(@guest.name)
      expect(@serialize_guest_returned[:rspv]).to eql(@guest.rspv)
    end

    it('returns sorted meal choices correctly') do
      expect(@serialize_guest_returned[:meal_choices][:starter][0][:name]).to eql("Test Starter One")
      expect(@serialize_guest_returned[:meal_choices][:main][0][:name]).to eql("Test Main Three")
      expect(@serialize_guest_returned[:meal_choices][:desert][0][:name]).to eql("Test Desert Four")
    end
  end
end

