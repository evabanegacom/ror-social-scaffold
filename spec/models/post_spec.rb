require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validation tests' do
    it { should validate_presence_of(:content) }
    it {
      should validate_length_of(:content)
        .is_at_most(1000)
        .with_message('1000 characters in post is the maximum allowed.')
    }
  end
end
