require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    describe 'basic associations' do
      it { should have_many(:posts) }
      it { should have_many(:likes) }
      it { should have_many(:comments) }

      it { should have_many(:liked_posts).through(:likes) }
      it { should have_many(:liked_comments).through(:likes) }
    end

    describe 'friendships' do
      it { should have_many(:friendships) }
      it { should have_many(:friends).through(:friendships) }
      it { should have_many(:inverse_friendships) }
      it { should have_many(:inverse_friends).through(:inverse_friendships) }
      it { should have_many(:sent_friend_requests) }
      it { should have_many(:received_friend_requests) }
    end

    describe 'validations' do
      it { should validate_presence_of(:username) }
      it { should validate_length_of(:username).is_at_least(3) }
      # this fails when sending emails ?!
      # SMTP cannot be empty error...
      # it { should validate_uniqueness_of(:username) }
    end
  end
end
