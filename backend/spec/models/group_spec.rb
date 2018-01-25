require 'rails_helper'

RSpec.describe Group, type: :model do
  let(:my_group) { Group.create(name: 'Yoga') }
  it { should have_and_belong_to_many(:users) }
  it { should validate_presence_of(:name) }

  describe "attributes" do
     it "has name" do
        expect(my_group).to have_attributes(name: 'Yoga')
     end
  end
end
