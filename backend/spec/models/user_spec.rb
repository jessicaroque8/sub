require 'rails_helper'

RSpec.describe User, type: :model do

# uid attribute is automatically populated by Devise Token Auth after provider attribute is set to email.
  let(:my_user) { User.create(staff_id_mb: 100000315, first_name: 'Erin', last_name: 'Coffey', email: 'test@email.com', password: 'abc12345', provider: 'email', uid: 'test@email.com') }
  it { should have_and_belong_to_many(:groups) }
  it { should have_many(:sub_requests).through(:sendees) }
  it { should have_many(:replies).through(:sendees) }

  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }

  describe "attributes" do
     it "has staff_id_mb, first_name, last_name, email, password_digest" do
        expect(my_user).to have_attributes(staff_id_mb: 100000315, first_name: 'Erin', last_name: 'Coffey', email: 'test@email.com', password: 'abc12345', provider: 'email')
     end
  end

  describe "uniqueness" do
     subject { User.create(staff_id_mb: 100000124, first_name: 'Sammy', last_name: 'Coffey', email: 'sammy@email.com', password: 'abc12345', provider: 'email', uid: 'sammy@email.com') }
     it { should validate_uniqueness_of(:staff_id_mb)}
  end

end
