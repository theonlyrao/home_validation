require 'rails_helper'

RSpec.describe Picture, type: :model do
  it { should have_and_belong_to_many(:homes) }
end
