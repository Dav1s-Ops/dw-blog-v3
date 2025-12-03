class ContactsController < ApplicationController
  def create
    sender_email = params[:email]
    message = params[:message]
    send_copy = params[:send_copy].present?

    # TEMPORARY DISABLE – SPAM PROTECTION
    respond_to do |format|
      format.html { redirect_to root_path, alert: "Contact form is temporarily disabled for maintenance." }
      format.json { render json: { error: "Contact form is temporarily disabled." }, status: :service_unavailable }
    end
    return

    if sender_email.blank? || message.blank?
      respond_to do |format|
        format.html { redirect_to root_path, alert: "Email and message are required." }
        format.json { render json: { error: "Email and message are required.", flash: { alert: "Email and message are required." } }, status: :unprocessable_entity }
      end
      return
    end

    ContactMailer.feedback(sender_email, message).deliver_later
    if send_copy
      ContactMailer.feedback_copy(sender_email, message).deliver_later
    end

    respond_to do |format|
      format.html { redirect_to root_path, notice: "Message sent successfully!" }
      format.json { render json: { message: "Message sent successfully!", flash: { notice: "Message sent successfully!" } }, status: :ok }
    end
  rescue StandardError => e
    respond_to do |format|
      format.html { redirect_to root_path, alert: "Failed to send message: #{e.message}" }
      format.json { render json: { error: "Failed to send message: #{e.message}", flash: { alert: "Failed to send message: #{e.message}" } }, status: :internal_server_error }
    end
  end
end
