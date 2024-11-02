require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.new(email: "test@example.com", password: "password123") }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(user).to be_valid
    end

    it 'is not valid without an email' do
      user.email = nil
      expect(user).to_not be_valid
    end

    it 'is not valid without a password' do
      user.password = nil
      expect(user).to_not be_valid
    end

    it 'is not valid with a duplicate email' do
      User.create(email: "test@example.com", password: "password123")
      expect(user).to_not be_valid
    end

    it 'is not valid with an invalid email format' do
      user.email = "invalid_email"
      expect(user).to_not be_valid
    end
  end
end
