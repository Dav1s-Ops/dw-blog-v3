require 'rails_helper'

RSpec.describe ContactMailer, type: :mailer do
  let(:sender_email) { 'user@example.com' }
  let(:message) { 'Great app!' }

  describe '#feedback' do
    let(:mail) { ContactMailer.feedback(sender_email, message) }

    it 'renders the headers' do
      expect(mail.subject).to eq('New Feedback from Contact Form')
      expect(mail.to).to eq([ 'davis@dw-code-blog.dev' ])
      expect(mail.from).to eq([ sender_email ])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match(message)
      expect(mail.body.encoded).to match(sender_email)
    end
  end

  describe '#feedback_copy' do
    let(:mail) { ContactMailer.feedback_copy(sender_email, message) }

    it 'renders the headers' do
      expect(mail.subject).to eq('Copy of Your Feedback Submission')
      expect(mail.to).to eq([ sender_email ])
      expect(mail.from).to eq([ 'no-reply@dw-code-blog.dev' ])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match(message)
      expect(mail.body.encoded).to match(sender_email)
    end
  end
end
