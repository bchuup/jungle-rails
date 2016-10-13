class UserMailer < ApplicationMailer
  default from: 'no-reply@jungle.com'

  def receipt_email(order, user)
    @user = user
    @order = order
    mail(to:@user.email, subject: "Receipt for purchase")
  end
end
