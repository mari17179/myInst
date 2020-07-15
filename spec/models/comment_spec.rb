require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject { build(:comment) }

  it { should belong_to(:user).without_validating_presence }
  it { should belong_to(:post).without_validating_presence }

  it { is_expected.to validate_presence_of(:comment) }
end
