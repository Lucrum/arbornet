class UserMailer < ApplicationMailer
  default from: "signup@arbornet.com"

  def welcome_email
    @user = params[:user]
    @url = "https://arbornet.com/login"
    mail(to: @user.email, subject: "Welcome to Arbornet")
  end
end
