class ContactMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contact_mailer.message.subject
  #
  def form_message(message)
    mail(:to => "office@pitamte.com", :subject => message.subject, :from => message.email)
  end
end
