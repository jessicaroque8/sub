require 'rails_helper'

RSpec.describe Sendee, type: :model do
   it { should belong_to(:sub_request) }
   it { should belong_to(:user) }
   it { should have_one(:reply) }

   it { should validate_presence_of(:sub_request_id) }
   it { should validate_presence_of(:user_id) }

   startdatetime = Faker::Time.forward(23, :morning)
   enddatetime = Faker::Time.forward(23, :morning)

   let!(:my_user) { User.create(staff_id_mb: 100000164, first_name: 'Jennifer', last_name: 'Anderson')}
   let!(:my_group) { Group.create(name: 'Yoga') }
   let!(:my_sub_request) { SubRequest.create(user_id: my_user.id, group_id: my_group.id, start_date_time: startdatetime, end_date_time: enddatetime, class_name: 'Vinyasa Yoga', class_id_mb: 1000, note: 'Please cover me')}

   let!(:my_sendee) { Sendee.create(sub_request_id: my_sub_request.id, user_id: my_user.id) }

   describe "attributes" do
      it "has attributes sub_request_id, and user_id" do
         expect(my_sendee).to have_attributes(sub_request_id: my_sub_request.id, user_id: my_user.id)
      end
   end

   describe "after create" do
      it "creates a reply associated with the sendee" do
         expect(Reply.count).to eq(1)
         expect(Reply.first).to have_attributes(sendee_id: my_sendee.id, sub_request_id: my_sub_request.id)
      end
   end

end
