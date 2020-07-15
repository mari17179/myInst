require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:user) { create :user }
  let(:params) { { user_id: user } }

  before { sign_in user }

  describe '#index' do
    subject { get :index, params: params }

    let!(:post) { create :post, user: user }

    it 'get all @posts' do
      subject
      expect(assigns(:posts)).to eq([post])
    end

    it { is_expected.to render_template('index') }
  end

  describe '#create' do
    let(:postParams) do
      {
        user_id: user.id,
        post: attributes_for(:post)
      }
    end
    subject { post :create, params: postParams }

    it 'creating post ends successfull' do
      is_expected.to redirect_to(assigns(:post))
    end
  end
end
