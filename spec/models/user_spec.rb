require 'rails_helper'

RSpec.describe User, type: :model do

  let(:my_user) { User.create(staff_id_mb: 0, first_name: 'Kali', last_name: 'Shakti', email: 'kali@email.com', login_location: 'Clubville', mobile_phone: 3333333, work_phone: 8888888, home_phone: 4444444) }
  it { should have_and_belong_to_many(:groups) }
  it { should have_many(:sub_requests).through(:sendees) }
  it { should have_many(:responses).through(:sendees) }

  describe "attributes" do
     it "has staff_id_mb, first_name, last_name, email, login_location, mobile_phone, work_phone, home_phone" do
        expect(my_user).to have_attributes(staff_id_mb: 0, first_name: 'Kali', last_name: 'Shakti', email: 'kali@email.com', login_location: 'Clubville', mobile_phone: 3333333, work_phone: 8888888, home_phone: 4444444)
     end
  end

end
