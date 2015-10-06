require 'rails_helper'

RSpec.describe SessionController, type: :controller do

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
  end

  context 'is_logged_in route' do
    context 'when logged in' do
      it 'returns 200' do
        session['user'] = @user.id

        get :is_logged_in
        expect(response.status).to eql(200)

        session['user'] = nil
      end
    end

    context 'when not logged in' do
      it 'returns 403' do
        get :is_logged_in
        expect(response.status).to eql(403)
      end
    end
  end

  context 'login route' do

    it 'returns appropriately when posting incorrect params' do
      post :login, {}.to_json, 'CONTENT_TYPE' => 'application/json'

      data = JSON.parse(response.body)

      expect(response.status).to eql(400)
      expect(data['error']).to eql(['Bad Request'])
      expect(data['data']).to eql({})
      expect(session['user']).to eql(nil)
    end

    it 'returns appropriately when posting incorrect login credentials' do
      post :login, {'password' => 'wrong password'}.to_json, 'CONTENT_TYPE' => 'application/json'

      data = JSON.parse(response.body)

      expect(response.status).to eql(403)
      expect(data['error']).to eql(['Incorrect Password'])
      expect(data['data']).to eql({})
      expect(session['user']).to eql(nil)
    end

    it 'returns appropriately when posting correct login credentials' do
      post :login, {'password' => 'test'}.to_json, 'CONTENT_TYPE' => 'application/json'

      data = JSON.parse(response.body)

      expect(response.status).to eql(200)
      expect(data['error']).to eql([])
      expect(data['data']['login']['id']).to eql(@user.id)
      expect(data['data']['login']['name']).to eql(@user.name)
      expect(data['data']['login']['guests'][0]['rspv']).to eql(@user.guests.first.rspv)
      expect(session['user']).to eql(@user.id)
    end

  end

  context 'logout route' do

    it 'deletes session when route is called' do
      session['user'] = @user.id

      get :logout

      data = JSON.parse(response.body)

      expect(response.status).to eql(200)
      expect(data['error']).to eql([])
      expect(session['user']).to eql(nil)
    end
  end

end
