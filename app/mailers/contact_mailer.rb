class ContactMailer < ApplicationMailer
  default from: "no-reply@dw-code-blog.dev"
  def feedback(sender_email, message)
    @message = message
    @sender_email = sender_email

    mail(to: "davis@dw-code-blog.dev",
        from: sender_email,
        subject: "New Feedback from Contact Form")
  end

  def feedback_copy(sender_email, message)
    @message = message
    @sender_email = sender_email

    mail(to: sender_email,
        subject: "Copy of Your Feedback Submission")
  end
end
