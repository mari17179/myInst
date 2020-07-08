require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'validation tests' do
    it 'ensures user_id presence' do
      post = Post.new(description: "Summer").save
      expect(post).to eq(false)
    end

    it 'should save successfully (with description of post)' do
      user = User.new(id: 1, username: 'Harry P', email: 'harryp@example.com', password: '123456', password_confirmation: '123456').save
      post = Post.new(user_id: 1, description: 'Hello', created_at: '2020-07-08 14:14:14', updated_at: '2020-07-08 14:16:16').save
      expect(post).to eq(true)
    end

    it 'should save successfully (without description of post)' do
      user = User.new(id: 1, username: 'Harry P', email: 'harryp@example.com', password: '123456', password_confirmation: '123456').save
      post = Post.new(user_id: 1,  created_at: '2020-07-08 14:14:14', updated_at: '2020-07-08 14:16:16').save
      expect(post).to eq(true)
    end
  end
end
