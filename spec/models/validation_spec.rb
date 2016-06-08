require 'rails_helper'

RSpec.describe Validation, type: :model do
  it { should belong_to(:home) }
  it { should have_many(:pictures).through(:home) }
end
