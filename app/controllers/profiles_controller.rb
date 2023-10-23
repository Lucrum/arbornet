class ProfilesController < ApplicationController
  before_action :check_profile_ownership, only: %i[edit update]
  def show
    @profile = User.eager_load(:posts)
                   .find_by(username: params[:username])
    
    @friendships = @profile.friendships.where(status: :accepted)
      .or(@profile.inverse_friendships.where(status: :accepted))

    if @profile == current_user
      @friendable = false
    else
      @friendable = user_friendable? @profile
    end
  end

  def edit
  end

  def update
    if @profile.update(clean_profile_params)
      redirect_to profile_path(@profile.username)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_friendable?(target_user)
    # are they currently friends?
    current_friends = current_user.friends + current_user.inverse_friends

    # does this user have a request sent to them?
    current_requests = Friendship.outstanding(current_user, target_user)
      .where(status: :pending)

    unless (target_user == current_user ||
      (current_friends.include? target_user) ||
      current_requests.any?)
      @friendable = true
    else
      @friendable = false
    end
  end

  def clean_profile_params
    res = {}
    profile_params.each do |param, value|
      profile_params[param] == "" ? res[param] = nil : res[param] = value
    end
    res
  end

  def profile_params
    params.require(:user).permit(
      :username, :location, :about_me
    )
  end

  def check_profile_ownership
    @profile = User.find_by(username: params[:username])
    redirect_to profile_path(@profile) unless @profile == current_user
  end
end
