require 'rails_helper'
require "#{Rails.root.join('lib')}/helpers/menu_item_helper.rb"

RSpec.describe MenuItemHelper do
  include MenuItemHelper

  before(:each) do
    @menu_items = {
      :starter => [],
      :main => [],
      :dessert => []
    }

    [
      ["Test Starter One","Test Starter One Description","V","starter"],
      ["Test Starter Two","Test Starter Two Description","","starter"],
      ["Test Starter Three","Test Starter Three Description","V","starter"],
      ["Test Starter Four","Test Starter Four Description","","starter"],
      ["Test Main One","Test Main One Description","V","main"],
      ["Test Main Two","Test Main Two Description","","main"],
      ["Test Main Three","Test Main Three Description","V","main"],
      ["Test Main Four","Test Main Four Description","","main"],
      ["Test Desert One","Test Desert One Description","V","dessert"],
      ["Test Desert Two","Test Desert Two Description","","dessert"],
      ["Test Desert Three","Test Desert Three Description","V","dessert"],
      ["Test Desert Four","Test Desert Four Description","","dessert"],
    ].each do |menu_item|
      @menu_items[menu_item[3].to_sym] << MenuItem.create(
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

      expect(@sort_into_types_returned[:dessert].count).to eql(4)

      @sort_into_types_returned[:dessert].each do |menu_item|
        expect(menu_item.meal_type).to eql('dessert')
      end
    end
  end

  context 'menu_item_request_invalid?' do
    context 'when provided with valid menu items' do
      before(:each) do
        mocked_request = [
          {
            :id => @menu_items[:starter].first.id
          },
          {
            :id => @menu_items[:main].first.id
          },
          {
            :id => @menu_items[:dessert].first.id
          }
        ]

        @menu_item_request_invalid_returned = MenuItemHelper.menu_item_request_invalid?(mocked_request)
      end

      it 'returns false to signify no errors' do
        expect(@menu_item_request_invalid_returned).to eql(false)
      end
    end

    context 'when provided with mostly valid menu items' do
      before(:each) do
        mocked_request = [
          {
            :id => @menu_items[:starter].first.id
          },
          {
            :id => -1
          },
          {
            :id => @menu_items[:dessert].first.id
          }
        ]

        @menu_item_request_invalid_returned = MenuItemHelper.menu_item_request_invalid?(mocked_request)
      end

      it 'returns correct error' do
        expect(@menu_item_request_invalid_returned).to eql('Menu items not supplied correctly')
      end
    end

    context 'when provided with too much of one meal type' do
      before(:each) do
        mocked_request = [
          {
            :id => @menu_items[:starter].first.id
          },
          {
            :id => @menu_items[:starter].last.id
          },
          {
            :id => @menu_items[:dessert].first.id
          }
        ]

        @menu_item_request_invalid_returned = MenuItemHelper.menu_item_request_invalid?(mocked_request)
      end

      it 'returns false to signify no errors' do
        expect(@menu_item_request_invalid_returned).to eql('You cannot have more than one menu item per type')
      end
    end

    context 'when provided with an incorrect number of menu items' do
      before(:each) do
        mocked_request = [
          {
            :id => @menu_items[:starter].first.id
          },
          {
            :id => @menu_items[:starter].last.id
          },
          {
            :id => @menu_items[:main].last.id
          },
          {
            :id => @menu_items[:dessert].first.id
          }
        ]

        @menu_item_request_invalid_returned = MenuItemHelper.menu_item_request_invalid?(mocked_request)
      end

      it 'returns false to signify no errors' do
        expect(@menu_item_request_invalid_returned).to eql('Menu items not supplied correctly')
      end
    end

    context 'when provided with nil' do
      before(:each) do
        @menu_item_request_invalid_returned = MenuItemHelper.menu_item_request_invalid?(nil)
      end

      it 'returns correct error' do
        expect(@menu_item_request_invalid_returned).to eql('Menu items not supplied correctly')
      end
    end

    context 'when provided with empty array' do
      before(:each) do
        @menu_item_request_invalid_returned = MenuItemHelper.menu_item_request_invalid?([])
      end

      it 'returns correct error' do
        expect(@menu_item_request_invalid_returned).to eql('Menu items not supplied correctly')
      end
    end

    context 'when provided with a string' do
      before(:each) do
        @menu_item_request_invalid_returned = MenuItemHelper.menu_item_request_invalid?('test')
      end

      it 'returns correct error' do
        expect(@menu_item_request_invalid_returned).to eql('Menu items not supplied correctly')
      end
    end
  end
end

