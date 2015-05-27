class MessagesController < ApplicationController
  def new
    @message = Message.new
  end

  def create
    @message = Message.new(params[:message])
    if @message.valid?
      mail = ContactMailer.form_message(@message)
      custom_smtp_settings = { domain: 'pitamte.com', port: '25' }
      mail.delivery_method.settings.merge! custom_smtp_settings
      mail.deliver
      redirect_to root_url, notice: "Message sent! Thank you for contacting us."
    else
      render "new"
    end
  end
end