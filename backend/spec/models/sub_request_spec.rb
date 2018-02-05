require 'rails_helper'
require 'faker'

RSpec.describe SubRequest, type: :model do
  let(:my_user) { User.create(staff_id_mb: 100000164, first_name: 'Jennifer', last_name: 'Anderson')}
  let(:my_group) { Group.create(name: 'Yoga') }

  startdatetime = Faker::Time.forward(23, :morning)
  enddatetime = Faker::Time.forward(23, :morning)

  let!(:my_sub_request) { SubRequest.create(user_id: my_user.id, group_id: my_group.id, start_date_time: startdatetime, end_date_time: enddatetime, class_name: 'Vinyasa Yoga', class_id_mb: 1000, note: 'Please cover me', awaiting_confirm: false, closed: false)}
  let!(:other_sub_request) { SubRequest.create(user_id: my_user.id, group_id: my_group.id, start_date_time: startdatetime, end_date_time: enddatetime, class_name: 'Vinyasa Yoga', class_id_mb: 1000, note: 'Please cover me')}

  it { should belong_to(:group) }
  it { should belong_to(:user) }
  it { should have_many(:sendees) }
  it { should have_many(:replies).through(:sendees) }

  it { should validate_presence_of(:start_date_time) }
  it { should validate_presence_of(:end_date_time) }
  it { should validate_presence_of(:class_name) }
  it { should validate_presence_of(:class_id_mb) }

  describe "attributes" do
     it "has user_id, group_id, start_date_time, end_date_time, class_name, class_id_mb, note, awaiting_confirm, closed" do
        expect(my_sub_request).to have_attributes(user_id: my_user.id, group_id: my_group.id, start_date_time: startdatetime, end_date_time: enddatetime, class_name: 'Vinyasa Yoga', class_id_mb: 1000, note: 'Please cover me', awaiting_confirm: false, closed: false)
     end

     it "sets awaiting_confirm and closed as false by default" do
        expect(other_sub_request).to have_attributes(user_id: my_user.id, group_id: my_group.id, start_date_time: startdatetime, end_date_time: enddatetime, class_name: 'Vinyasa Yoga', class_id_mb: 1000, note: 'Please cover me', awaiting_confirm: false, closed: false)
     end
  end

end
