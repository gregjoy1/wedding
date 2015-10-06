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

end

