require 'rails_helper'
require "#{Rails.root.join('lib')}/helpers/session_helper.rb"

RSpec.describe SessionHelper do
  include SessionHelper

  before(:all) do
    @guest = Guest.create(
      :name => 'Test Guest',
      :password => HashHelper.password_hash('test')
    )
  end

  after(:all) do
    @guest.destroy!
  end

  context 'is_logged_in' do
    context 'when logged in with existing user' do
      before(:all) do
        @session = {
          :user => @guest.id
        }
        @is_logged_in_returned = SessionHelper.is_logged_in(@session)
      end

      it('returns guest') do
        expect(@is_logged_in_returned).to eql(@guest)
      end
    end

    context 'when logged in with non-existing user' do
      before(:all) do
        @session = {
          :user => 'test'
        }
        @is_logged_in_returned = SessionHelper.is_logged_in(@session)
      end

      it('returns guest') do
        expect(@is_logged_in_returned).to eql(nil)
      end
    end

    context 'when not logged in' do
      before(:all) do
        @session = {}
        @is_logged_in_returned = SessionHelper.is_logged_in(@session)
      end

      it('returns guest') do
        expect(@is_logged_in_returned).to eql(nil)
      end
    end
  end

  context 'login' do
    context 'provided with incorrect login credentials' do
      before(:all) do
        @session = {
          :user => 'test'
        }
        @login_returned = SessionHelper.login(@session, 'wrong password')
      end

      it('returns nil') do
        expect(@login_returned).to eql(nil)
      end

      it('correctly clear session') do
        expect(@session['user']).to eql(nil)
      end
    end

    context 'provided with correct login credentials' do
      before(:all) do
        @session = {}
        @login_returned = SessionHelper.login(@session, 'test')
      end

      it('returns guest') do
        expect(@login_returned.id).to eql(@guest.id)
      end

      it('correctly updates session') do
        expect(@session[:user]).to eql(@guest.id)
      end
    end
  end

  context 'logout' do
    before(:all) do
      @session = {}
      @logout_returned = SessionHelper.logout(@session)
    end

    it('returns nil') do
      expect(@logout_returned).to eql(nil)
    end

    it('correctly updates session') do
      expect(@session[:user]).to eql(nil)
    end
  end
end
