class ContactMailer < ApplicationMailer
  default from: "no-reply@dw-code-blog.dev"
  def feedback(sender_email, message, send_copy = false)
    @message = message
    @sender_email = sender_email

    mail(to: "davis@dw-code-blog.dev",
        from: sender_email,
        subject: "Feedback from Contact Form")

    if send_copy
      mail(to: sender_email,
          subject: "Copy of Feedback Form Submission")
    end
  end
end
