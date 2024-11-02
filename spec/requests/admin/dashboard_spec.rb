require 'rails_helper'

RSpec.describe "Admin::Dashboards", type: :request do
  let(:user) { User.create(email: "test@test.com", password: "password" ) }

  before do
    sign_in user
  end
  describe "GET /index" do
    it "returns http success" do
      get "/admin/dashboard"
      expect(response).to have_http_status(:success)
    end
  end

end
