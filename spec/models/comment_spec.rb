require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'validation tests' do
    it 'ensures user_id presence' do
      user = User.new(id: 1, username: 'Harry P', email: 'harryp@example.com', password: '123456', password_confirmation: '123456').save
      post = Post.new(id: 1, user_id: 1, description: 'Hello', created_at: '2020-07-08 14:14:14', updated_at: '2020-07-08 14:16:16').save
      comment = Comment.new(post_id: 1, comment: "Hello", created_at: '2020-07-08 14:14:14', updated_at: '2020-07-08 14:16:16').save
      expect(comment).to eq(false)
    end

    it 'ensures post_id presence' do
      user = User.new(id: 1, username: 'Harry P', email: 'harryp@example.com', password: '123456', password_confirmation: '123456').save
      post = Post.new(id: 1, user_id: 1, description: 'Hello', created_at: '2020-07-08 14:14:14', updated_at: '2020-07-08 14:16:16').save
      comment = Comment.new(user_id: 1, comment: "Hello", created_at: '2020-07-08 14:14:14', updated_at: '2020-07-08 14:16:16').save
      expect(comment).to eq(false)
    end

    it 'should save successfully' do
      user = User.new(id: 1, username: 'Harry P', email: 'harryp@example.com', password: '123456', password_confirmation: '123456').save
      post = Post.new(id: 1, user_id: 1, description: 'Hello', created_at: '2020-07-08 14:14:14', updated_at: '2020-07-08 14:16:16').save
      comment = Comment.new(user_id: 1, post_id: 1, comment: "Hello", created_at: '2020-07-08 14:14:14', updated_at: '2020-07-08 14:16:16').save
      expect(comment).to eq(true)
    end

  end
end
