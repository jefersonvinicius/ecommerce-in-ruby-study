class ApplicationMailer < ActionMailer::Base
  default from: "jeferson.viniciuscrc@gmail.com"
  layout "mailer"

  def welcome_email
    @user = params[:user]
    mail(to: @user.email, subject: 'Welcome!')
  end
end
