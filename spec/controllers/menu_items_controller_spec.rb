require 'rails_helper'

RSpec.describe MenuItemsController, type: :controller do

  before(:all) do
    Login.destroy_all
    Guest.destroy_all

    @user = Login.create(
      :name => 'Test Guest',
      :password => HashHelper.password_hash('test')
    )

    @user.guests << Guest.create(
      name: 'Test Guest',
      rspv: '-'
    )

    [
      ["Test Starter One","Test Starter One Description","V","starter"],
      ["Test Main Three","Test Main Three Description","V","main"],
      ["Test Desert Four","Test Desert Four Description","","dessert"]
    ].each do |menu_item|
      MenuItem.create(
        name: menu_item[0],
        description: menu_item[1],
        labels: menu_item[2],
        meal_type: menu_item[3]
      )
    end

  end

  after(:all) do
    MenuItem.destroy_all
  end

  context 'get_all_menu_items route' do
    context 'when logged in' do
      it 'returns 200' do
        session['user'] = @user.id

        get :get_all_menu_items

        data = JSON.parse(response.body)

        expect(response.status).to eql(200)

        expect(data['data']['menu_items']['starter'][0]['name']).to eql('Test Starter One')
        expect(data['data']['menu_items']['main'][0]['name']).to eql('Test Main Three')
        expect(data['data']['menu_items']['dessert'][0]['name']).to eql('Test Desert Four')

        session['user'] = nil
      end
    end

    context 'when not logged in' do
      it 'returns 403' do
        get :get_all_menu_items
        expect(response.status).to eql(403)
      end
    end
  end
end

