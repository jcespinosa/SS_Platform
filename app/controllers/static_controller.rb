class StaticController < ApplicationController
  def home
    @user = User.new
  end

  def userCases
  end

  def survey
  end
end
