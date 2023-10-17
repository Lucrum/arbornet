class ProfilesController < ApplicationController
  def show
    @profile = User.find(params[:id])
  end

  def update
  end
end
