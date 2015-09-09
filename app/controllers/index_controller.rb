class IndexController < ApplicationController
  def index
    @test = 'test'
    if session[:test].present?
      render plain: "is there though"
    else
      render plain: "teststststtsts"
    end
  end
end
