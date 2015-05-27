class MessagesController < ApplicationController
  def new
    @message = Message.new
  end

  def create
    @message = Message.new(params[:message])
    if @message.valid?
      mail = ContactMailer.create_message(@message)
      custom_smtp_settings = { address: 'office@pitamte.com', domain: 'pitamte.com' }
      mail.delivery_method.settings = custom_smtp_settings
      mail.deliver
      redirect_to root_url, notice: "Message sent! Thank you for contacting us."
    else
      render "new"
    end
  end
end