require 'rails_helper'

RSpec.describe "Posts", type: :request do
  let(:user) { User.create(email: 'test@test.com', username: 'testymctest', password: "password", password_confirmation: "password") }
  describe "GET /index" do
    context "user is not signed in" do
      it "redirects to the sign in page" do
        get "/posts"
        expect(response).to have_http_status(:redirect)
      end
    end

    context "user is signed in" do
      before { sign_in user }
      it "loads the page" do
        get "/posts"
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "GET /post" do
    before { sign_in user }
    context "there is a post" do
      before do
        post_content = "Hello, world!"
        new_post = user.posts.build(content: post_content)
        new_post.save
      end

      it "displays a post" do
        get "/posts/1"
        expect(response).to have_http_status(:success)
        expect(response.body).to include("Post by")
      end

      it "loads edit page" do
        get "/posts/1/edit"
        expect(response).to have_http_status(:success)
      end
    end
  end
end
