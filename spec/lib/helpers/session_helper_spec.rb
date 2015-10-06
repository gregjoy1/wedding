require 'rails_helper'
require "#{Rails.root.join('lib')}/helpers/session_helper.rb"

RSpec.describe SessionHelper do
  include SessionHelper

  before(:all) do
    Login.destroy_all
    Guest.destroy_all

    @user_agent = 'test user agent'
    @login = Login.create(
      :name => 'Test Login',
      :password => HashHelper.password_hash('test')
    )
  end

  context 'is_logged_in' do
    context 'when logged in with existing user' do
      before(:all) do
        LoginHistory.destroy_all

        @login_history_time = (Time.now - 1.hour)
        LoginHistory.create(
          :user_agent => @user_agent,
          :logged_in => @login_history_time,
          :last_activity => @login_history_time
        )

        @session = {
          :user => @login.id
        }
        @is_logged_in_returned = SessionHelper.is_logged_in(@session, @user_agent)
      end

      it('returns login') do
        expect(@is_logged_in_returned).to eql(@login)
      end

      it('updates login history') do
        expect(LoginHistory.last.user_agent).to eql(@user_agent)
        expect(LoginHistory.last.last_activity).to_not eql(@login_history_time)
      end
    end

    context 'when logged in with non-existing user' do
      before(:all) do
        @session = {
          :user => 'test'
        }
        @is_logged_in_returned = SessionHelper.is_logged_in(@session, @user_agent)
      end

      it('returns login') do
        expect(@is_logged_in_returned).to eql(nil)
      end
    end

    context 'when not logged in' do
      before(:all) do
        @session = {}
        @is_logged_in_returned = SessionHelper.is_logged_in(@session, @user_agent)
      end

      it('returns login') do
        expect(@is_logged_in_returned).to eql(nil)
      end
    end
  end

  context 'login' do
    context 'provided with incorrect login credentials' do
      before(:all) do
        LoginHistory.destroy_all
        @session = {
          :user => 'test'
        }
        @login_returned = SessionHelper.login(@session, 'wrong password', @user_agent)
      end

      it('returns nil') do
        expect(@login_returned).to eql(nil)
      end

      it('correctly clear session') do
        expect(@session['user']).to eql(nil)
      end

      it('correctly does not create login history entry') do
        latest_login_history = LoginHistory.where(:login_id => @session['user']).last

        expect(latest_login_history).to eql(nil)
      end
    end

    context 'provided with correct login credentials' do
      before(:all) do
        @session = {}
        @login_returned = SessionHelper.login(@session, 'test', @user_agent)
      end

      it('returns login') do
        expect(@login_returned.id).to eql(@login.id)
      end

      it('correctly updates session') do
        expect(@session[:user]).to eql(@login.id)
      end

      it('correctly creates login history entry') do
        latest_login_history = LoginHistory.where(:login_id => @login_returned.id).last

        expect(latest_login_history.last_activity.today?).to eql(true)
        expect(latest_login_history.logged_in.today?).to eql(true)
        expect(latest_login_history.user_agent).to eql(@user_agent)
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
