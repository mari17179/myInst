require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation tests' do
    it 'ensures username presence' do
      user = User.new(email: 'harry@example.com', password: '123456', password_confirmation: '123456').save
      expect(user).to eq(false)
    end

    it 'ensures email presence' do
      user = User.new(username: 'Harry', password: '123456', password_confirmation: '123456').save
      expect(user).to eq(false)
    end

    it 'ensures password presence' do
      user = User.new(username: 'Harry', password_confirmation: '123456').save
      expect(user).to eq(false)
    end

    it 'ensures password_confirmation presence' do
      user = User.new(username: 'Harry', password: '123456').save
      expect(user).to eq(false)
    end

    it 'should save successfully' do
      user = User.new(username: 'Harry P', email: 'harryp@example.com', password: '123456', password_confirmation: '123456').save
      expect(user).to eq(true)
    end
  end

  context 'uniq tests' do

    it 'ensures email is unique' do
      user1 = User.new(username: 'Harry Potte', email: 'harryp@example.com', password: '123456', password_confirmation: '123456').save
      user2 = User.new(username: 'Harry Po', email: 'harryp@example.com', password: '123456', password_confirmation: '123456').save
      expect(user1).to eq(true)
      expect(user2).to eq(false)
    end

  end
end
