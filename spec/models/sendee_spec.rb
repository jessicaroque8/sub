require 'rails_helper'

RSpec.describe Sendee, type: :model do
   it { should belong_to(:sub_request) }
   it { should belong_to(:user) }
   it { should have_one(:reply) }

   startdatetime = Faker::Time.forward(23, :morning)
   enddatetime = Faker::Time.forward(23, :morning)

   let!(:my_user) { User.create(staff_id_mb: 100000164, first_name: 'Jennifer', last_name: 'Anderson')}
   let!(:my_group) { Group.create(name: 'Yoga') }
   let!(:my_sub_request) { SubRequest.create(user_id: my_user.id, group_id: my_group.id, start_date_time: startdatetime, end_date_time: enddatetime, class_name: 'Vinyasa Yoga', class_id_mb: 1000, note: 'Please cover me')}

   let!(:my_sendee) { Sendee.create(sub_request_id: my_sub_request.id, user_id: my_user.id, sub: false, has_replied: false) }

   describe "attributes" do
      it "has attributes sub and has_responded" do
         expect(my_sendee).to have_attributes(sub_request_id: my_sub_request.id, user_id: my_user.id, sub: false, has_replied: false)
      end

      it "has default: false for sub attribute" do
         sendee = Sendee.create(sub_request_id: my_sub_request.id, user_id: my_user.id)
         expect(sendee.sub).to eq(false)
      end

      it "has default: false for has_replied attribute" do
         sendee = Sendee.create(sub_request_id: my_sub_request.id, user_id: my_user.id)
         expect(sendee.has_replied).to eq(false)
      end
   end
end
