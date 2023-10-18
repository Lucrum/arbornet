class ProfilesController < ApplicationController
  def show
    @profile = User.find_by(username: params[:username])
  end

  def update
  end
end
