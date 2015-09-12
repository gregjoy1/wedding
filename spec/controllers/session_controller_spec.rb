require 'rails_helper'

RSpec.describe SessionController, type: :controller do

  before(:all) do
    @guest = Guest.create(
      :name => 'Test Guest',
      :password => HashHelper.password_hash('test')
    )
  end

  context 'is_logged_in route' do
    context 'when not logged in' do
      it 'returns 403' do
        get :is_logged_in
        expect(response.status).to eql(403)
      end
    end
  end

  context 'login route' do

    it 'returns 400 when posting incorrect params' do
      post :login, {}.to_json, 'CONTENT_TYPE' => 'application/json'
      expect(response.status).to eql(400)
    end

    it 'returns 403 when posting incorrect login credentials' do
      post :login, {'password' => 'wrong password'}.to_json, 'CONTENT_TYPE' => 'application/json'
      expect(response.status).to eql(403)
    end

    it 'returns 200 when posting correct login credentials' do
      post :login, {'password' => 'test'}.to_json, 'CONTENT_TYPE' => 'application/json'
      expect(response.status).to eql(200)
    end

  end

end
