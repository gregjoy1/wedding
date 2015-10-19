require 'rails_helper'
require "#{Rails.root.join('lib')}/helpers/menu_item_helper.rb"

RSpec.describe MenuItemHelper do
  include MenuItemHelper

  before(:each) do
    [
      ["Test Starter One","Test Starter One Description","V","starter"],
      ["Test Starter Two","Test Starter Two Description","","starter"],
      ["Test Starter Three","Test Starter Three Description","V","starter"],
      ["Test Starter Four","Test Starter Four Description","","starter"],
      ["Test Main One","Test Main One Description","V","main"],
      ["Test Main Two","Test Main Two Description","","main"],
      ["Test Main Three","Test Main Three Description","V","main"],
      ["Test Main Four","Test Main Four Description","","main"],
      ["Test Desert One","Test Desert One Description","V","desert"],
      ["Test Desert Two","Test Desert Two Description","","desert"],
      ["Test Desert Three","Test Desert Three Description","V","desert"],
      ["Test Desert Four","Test Desert Four Description","","desert"],
    ].each do |menu_item|
      MenuItem.create(
        name: menu_item[0],
        description: menu_item[1],
        labels: menu_item[2],
        meal_type: menu_item[3]
      )
    end
  end

  after(:each) do
    MenuItem.all.destroy_all
  end

  context 'sort_into_types' do
    before(:each) do
      @sort_into_types_returned = MenuItemHelper.sort_into_types(MenuItem.all)
    end

    it('sorts menu_items correctly') do
      expect(@sort_into_types_returned[:starter].count).to eql(4)

      @sort_into_types_returned[:starter].each do |menu_item|
        expect(menu_item.meal_type).to eql('starter')
      end

      expect(@sort_into_types_returned[:main].count).to eql(4)

      @sort_into_types_returned[:main].each do |menu_item|
        expect(menu_item.meal_type).to eql('main')
      end

      expect(@sort_into_types_returned[:desert].count).to eql(4)

      @sort_into_types_returned[:desert].each do |menu_item|
        expect(menu_item.meal_type).to eql('desert')
      end
    end
  end
end


