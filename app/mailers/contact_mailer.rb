class ContactMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contact_mailer.message.subject
  #
  def create_message(message)
    subject message.subject
    body :message => message
    recepients "office@pitamte.com"
    from message.mail
    sent_on Time.now
    mail to: "office@pitamte.com"
  end
end
