require 'rails_helper'
require "#{Rails.root.join('lib')}/helpers/hash_helper.rb"

RSpec.describe SessionHelper do
  include HashHelper

  before(:each) do
  end

  context 'password_hash' do
    before(:each) do
      @password_hash_returned = HashHelper.password_hash("test")
    end

    it('returns hash correctly') do
      expect(@password_hash_returned).to eql("72e3ae3d5fed6f34a114fb0558684245b7c11c8938ea8d1982103c20af6dbc44")
    end
  end

  context 'interleave_strings' do
    before(:each) do
      @interleave_strings_returned = HashHelper.interleave_strings("hahahahah", "yes hello")
    end

    it('returns interleaved strings correctly') do
      expect(@interleave_strings_returned).to eql("hyaehsa hhaehlalho")
    end
  end
end


