require 'rails_helper'

RSpec.describe Like, type: :model do
  subject { build(:like) }

  it { should belong_to(:user).without_validating_presence }
  it { should belong_to(:post).without_validating_presence }

end
