class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.notify_comment.subject
  #
  def notify_comment(po, comment, user)
    @user = user
    @po = po
    @comment = @po.comments

    # mail to: user.email, :subject =>  "new post wanna check?"
    #先關掉＝＝
  end
end
