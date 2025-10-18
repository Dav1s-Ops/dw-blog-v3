class ContactMailer < ApplicationMailer
  default from: "feedback@dw-code-blog.dev"

  def feedback(sender_email, message)
    @sender_email = sender_email
    @message = message
    mail(
      to: "davis@dw-code-blog.dev",
      reply_to: sender_email,
      subject: "New Feedback from Blog Form"
    )
  end

  def feedback_copy(sender_email, message)
    @sender_email = sender_email
    @message = message
    mail(
      to: sender_email,
      subject: "Copy of Your Message to DW Code Blog"
    )
  end
end
