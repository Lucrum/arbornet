require 'rails_helper'

RSpec.describe "Profiles", type: :request do
  let(:user) { User.create(email: 'test@test.com', username: 'testymctest', password: "password", password_confirmation: "password") }
  describe "GET /profiles/testymctest" do
    before { sign_in user }
    context "user is signed in" do
      it "loads user profile" do
        get "/profiles/testymctest"
        expect(response).to have_http_status(:success)
      end
    end
  end
end
