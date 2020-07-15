require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'following and unfollowing' do
    let(:ron) { create(:user, username: 'Ron Weasley') }
    let(:dean) { create(:user, username: 'Dean') }

    it 'if user1 follows user2, user1 will be follower of user2' do
      ron.follow(dean)
      expect(dean.followers).to include(ron)
    end

    it 'if user1 follows user2, user2 will be following by user1' do
      ron.follow(dean)
      expect(ron.following?(dean)).to be_truthy
    end

    it 'if user1 follows user2 and then unfollow user2, user1 will not be follower of user2' do
      ron.follow(dean)
      ron.unfollow(dean)
      expect(dean.followers).not_to include(ron)
    end
  end
end
