require 'rails_helper'

RSpec.describe User, type: :model do
     subject { build(:user) }

     it { is_expected.to validate_presence_of(:username) }
     it { is_expected.to validate_presence_of(:email) }
     it { is_expected.to validate_presence_of(:password) }

     it { is_expected.to have_many(:posts) }
     it { is_expected.to have_many(:likes) }
     it { is_expected.to have_many(:comments) }

     it { is_expected.to have_many(:passive_follows).with_foreign_key(:following_id).class_name("Follow") }
     it { is_expected.to have_many(:followers).through(:passive_follows).source(:follower) }

     it { is_expected.to have_many(:active_follows).with_foreign_key(:follower_id).class_name("Follow") }
     it { is_expected.to have_many(:followings).through(:active_follows).source(:following) }

end
