require 'rails_helper'
require "#{Rails.root.join('lib')}/helpers/api_helper.rb"

RSpec.describe SessionHelper do
  include ApiHelper

  before(:all) do
  end

  context 'serialize_response' do
    before(:all) do
      @error = {
        :error => 'error'
      }

      @data = {
        :test => 'test'
      }

      @serialize_response_returned = ApiHelper.serialize_response(@error, @data)
    end

    it('returns error correctly') do
      expect(@serialize_response_returned[:error]).to eql(@error)
    end

    it('returns data correctly') do
      expect(@serialize_response_returned[:data]).to eql(@data)
    end
  end

  context 'render_response' do
    before(:all) do
      error = {
        :error => 'error'
      }

      data = {
        :test => 'test'
      }

      render_response_returned = ApiHelper.render_response(error, data)
      @render_response_returned_data = JSON.parse(render_response_returned)
    end

    it('returns error correctly') do
      expect(@render_response_returned_data['error']['error']).to eql('error')
    end

    it('returns data correctly') do
      expect(@render_response_returned_data['data']['test']).to eql('test')
    end
  end
end
