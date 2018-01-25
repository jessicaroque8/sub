require 'rails_helper'

RSpec.describe User, type: :model do

  let(:my_user) { User.create(staff_id_mb: 100000315, first_name: 'Erin', last_name: 'Coffey', email: 'test@email.com', password_digest: 'abc12345') }
  it { should have_and_belong_to_many(:groups) }
  it { should have_many(:sub_requests).through(:sendees) }
  it { should have_many(:replies).through(:sendees) }

  describe "attributes" do
     it "has staff_id_mb, first_name, last_name, email, password_digest" do
        expect(my_user).to have_attributes(staff_id_mb: 100000315, first_name: 'Erin', last_name: 'Coffey', email: 'test@email.com', password_digest: 'abc12345')
     end
  end

end
