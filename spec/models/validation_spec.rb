require 'rails_helper'

RSpec.describe Validation, type: :model do
  it { should belong_to(:home) }
  it { should have_many(:pictures).through(:home) }

  it "knows a valid validation request" do
    turing = create(:home)
    picture_one = create(:picture)
    picture_two = create(:picture)
    turing.pictures << [picture_one, picture_two]
    
    validation = Validation.new(home_id: turing.id)
    validation.save
    
    expect(validation.pictures.count).to eq(2)
    expect(validation.home.id).to eq(turing.id)
    expect(validation.check_gps).to eq(true)
  end

  xit "knows an invalid validation request" do

    expect(validation.validated?).to eq(false)
  end
end
