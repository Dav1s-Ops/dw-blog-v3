class ContactsController < ApplicationController
  def create
    sender_email = params[:email]
    message = params[:message]
    send_copy = params[:send_copy].present?

    if sender_email.blank? || message.blank?
      # TODO: handle error
    end

    ContactMailer.feedback(sender_email, message, send_copy).deliver_later
  end
end
