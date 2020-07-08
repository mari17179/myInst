require 'rails_helper'

RSpec.describe Follow, type: :model do
  context 'validation tests' do
    it 'ensures follower_id presence' do
      user1 = User.new(id: 23, username: 'Harry23', email: 'harryp@example.com', password: '123456', password_confirmation: '123456').save
      user2 = User.new(id: 34, username: 'Hermione34', email: 'hermione@example.com', password: '123456', password_confirmation: '123456').save
      follow = Follow.new(following_id: 23,created_at: '2020-07-08 14:14:14', updated_at: '2020-07-08 14:16:16').save
      expect(follow).to eq(false)
    end

    it 'ensures following_id presence' do
      user1 = User.new(id: 12, username: 'Harry22', email: 'harryp@example.com', password: '123456', password_confirmation: '123456').save
      user2 = User.new(id: 22, username: 'Hermione22', email: 'hermione@example.com', password: '123456', password_confirmation: '123456').save
      follow = Follow.new(follower_id: 22,created_at: '2020-07-08 14:14:14', updated_at: '2020-07-08 14:16:16').save
      expect(follow).to eq(false)
    end

    it 'follow should save successfully' do
      uuser1 = User.new(id: 45, username: 'Harry45', email: 'harryp@example.com', password: '123456', password_confirmation: '123456').save
      user2 = User.new(id: 245, username: 'Hermione45', email: 'hermione@example.com', password: '123456', password_confirmation: '123456').save
      follow = Follow.new(following_id: 45, follower_id: 245,created_at: '2020-07-08 14:14:14', updated_at: '2020-07-08 14:16:16').save
      expect(follow).to eq(true)
    end

    it 'follows should save successfully' do
      uuser1 = User.new(id: 154, username: 'Harry54', email: 'harryp@example.com', password: '123456', password_confirmation: '123456').save
      user2 = User.new(id: 256, username: 'Hermione54', email: 'hermione@example.com', password: '123456', password_confirmation: '123456').save
      follow1 = Follow.new(following_id: 154, follower_id: 256,created_at: '2020-07-08 14:14:14', updated_at: '2020-07-08 14:16:16').save
      expect(follow1).to eq(true)
      follow2 = Follow.new(following_id: 256, follower_id: 154,created_at: '2020-07-08 14:14:14', updated_at: '2020-07-08 14:16:16').save
      expect(follow2).to eq(true)
    end

  end
end
