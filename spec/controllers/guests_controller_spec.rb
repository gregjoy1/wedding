require 'rails_helper'

RSpec.describe GuestsController do

  before(:each) do
    Login.destroy_all
    Guest.destroy_all

    @user1 = Login.create(
      :name => 'Test Guest One',
      :password => HashHelper.password_hash('test')
    )

    @user2 = Login.create(
      :name => 'Test Guest Two',
      :password => HashHelper.password_hash('test')
    )

    @user1.guests << Guest.create(
      name: 'Test Guest One',
      rspv: '-'
    )

    @user2.guests << Guest.create(
      name: 'Test Guest Two',
      rspv: '-'
    )

    @user1.save
    @user2.save
  end

  context 'update_guest route with updated rspv' do
    context 'when logged in with correct login' do
      before(:each) do
        session['user'] = @user1.id

        put :update_guest, guest_id: @user1.guests.first.id, rspv: 'coming', format: :json

        @data = JSON.parse(response.body)
        @user1.reload
      end

      after(:each) do
        session['user'] = nil
      end

      it 'returns the updated guest' do
        expect(@data['data']['guest']['rspv']).to eql('coming')
      end

      it 'updates the guest' do
        expect(@user1.guests.first.rspv).to eql('coming')
      end

      it 'returns 200' do
        expect(response.status).to eql(200)
      end
    end

    context 'when not logged in' do
      before(:each) do
        put :update_guest, guest_id: @user1.guests.first.id, rspv: 'coming', format: :json

        @data = JSON.parse(response.body)
      end

      it 'returns an error' do
        expect(@data['error'].count).to eql(1)
        expect(@data['error'][0]).to eql('Not authenticated to alter guest')
      end

      it 'returns 403' do
        expect(response.status).to eql(403)
      end
    end
  end

  context 'update_guest route with updated note' do
    context 'when logged in with correct login' do
      before(:each) do
        session['user'] = @user1.id

        put :update_guest, guest_id: @user1.guests.first.id, note: 'test note', format: :json

        @data = JSON.parse(response.body)
        @user1.reload
      end

      after(:each) do
        session['user'] = nil
      end

      it 'returns the updated guest' do
        expect(@data['data']['guest']['note']).to eql('test note')
      end

      it 'updates the guest' do
        expect(@user1.guests.first.note).to eql('test note')
      end

      it 'returns 200' do
        expect(response.status).to eql(200)
      end
    end

    context 'when not logged in' do
      before(:each) do
        put :update_guest, guest_id: @user1.guests.first.id, note: 'test note', format: :json

        @data = JSON.parse(response.body)
      end

      it 'returns an error' do
        expect(@data['error'].count).to eql(1)
        expect(@data['error'][0]).to eql('Not authenticated to alter guest')
      end

      it 'returns 403' do
        expect(response.status).to eql(403)
      end
    end
  end

  context 'update_guest route with menu items' do

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

    context 'when logged in with correct login' do
      before(:each) do
        session['user'] = @user1.id
      end

      after(:each) do
        session['user'] = nil
      end

      context 'when provided with valid menu items' do
        before(:each) do
          @mocked_request = [
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

          put :update_guest, guest_id: @user1.guests.first.id, menu_items: @mocked_request, format: :json

          @data = JSON.parse(response.body)
        end

        it 'does not return an error' do
          expect(@data['error'].count).to eql(0)
        end

        it 'returns 403' do
          expect(response.status).to eql(200)
        end

        it 'adds the menu items to the guest' do
          expect(@user1.guests[0].menu_items.count).to eql(3)

          @mocked_request.each_with_index do |menu_item, index|
            expect(@user1.guests[0].menu_items[index][:id]).to eql(menu_item[:id])
          end
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

          put :update_guest, guest_id: @user1.guests.first.id, menu_items: mocked_request, format: :json

          @data = JSON.parse(response.body)
        end

        it 'returns an error' do
          expect(@data['error'].count).to eql(2)
          expect(@data['error'][0]).to eql('Bad Request')
          expect(@data['error'][1]).to eql('Menu items not supplied correctly')
        end

        it 'returns 403' do
          expect(response.status).to eql(400)
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

          put :update_guest, guest_id: @user1.guests.first.id, menu_items: mocked_request, format: :json

          @data = JSON.parse(response.body)
        end

        it 'returns an error' do
          expect(@data['error'].count).to eql(2)
          expect(@data['error'][0]).to eql('Bad Request')
          expect(@data['error'][1]).to eql('You cannot have more than one menu item per type')
        end

        it 'returns 403' do
          expect(response.status).to eql(400)
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

          put :update_guest, guest_id: @user1.guests.first.id, menu_items: mocked_request, format: :json

          @data = JSON.parse(response.body)
        end

        it 'returns an error' do
          expect(@data['error'].count).to eql(2)
          expect(@data['error'][0]).to eql('Bad Request')
          expect(@data['error'][1]).to eql('Menu items not supplied correctly')
        end

        it 'returns 403' do
          expect(response.status).to eql(400)
        end
      end

      context 'when provided with empty array' do
        before(:each) do
          put :update_guest, guest_id: @user1.guests.first.id, menu_items: [], format: :json

          @data = JSON.parse(response.body)
        end

        it 'does not return an error' do
          expect(@data['error'].count).to eql(0)
        end

        it 'returns 200' do
          expect(response.status).to eql(200)
        end
      end

      context 'when provided with a string' do
        before(:each) do
          put :update_guest, :guest_id => @user1.guests.first.id, :menu_items => "test string", :format => :json

          @data = JSON.parse(response.body)
        end

        it 'returns an error' do
          expect(@data['error'].count).to eql(2)
          expect(@data['error'][0]).to eql('Bad Request')
          expect(@data['error'][1]).to eql('Menu items not supplied correctly')
        end

        it 'returns 403' do
          expect(response.status).to eql(400)
        end
      end
    end
  end

  context 'when not logged in' do
    before(:each) do
      put :update_guest, guest_id: @user1.guests.first.id, note: 'test note', format: :json

      @data = JSON.parse(response.body)
    end

    it 'returns an error' do
      expect(@data['error'].count).to eql(1)
      expect(@data['error'][0]).to eql('Not authenticated to alter guest')
    end

    it 'returns 403' do
      expect(response.status).to eql(403)
    end
  end
end
