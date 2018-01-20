require 'rails_helper'

RSpec.describe SubRequest, type: :model do
  let(:my_user) { User.create(User.create(staff_id_mb: 100000315, first_name: 'Erin', last_name: 'Coffey', email: 'erin@email.com')}
  let(:my_group) { Group.create(name: 'Yoga') }

  datetime = Faker::Time.forward(23, :morning)
  let!(:my_sub_request) { SubRequest.create(user_id: my_user.id, group_id: my_group.id, datetime: datetime, class_name: 'Vinyasa Yoga', class_id_mb: 1000, note: 'Please cover me')}

  it { should belong_to(:group) }
  it { should belong_to(:user) }
  it { should have_many(:sendees) }
  it { should have_many(:responses).through(:sendees) }

  describe "attributes" do
     it "has datetime, class_name, class_id_mb, note" do
        expect(my_sub_request).to have_attributes(user_id: my_user.id, group_id: my_group.id, datetime: time, class_name: 'Vinyasa Yoga', class_id_mb: 1000, note: 'Please cover me')
     end
  end

end
