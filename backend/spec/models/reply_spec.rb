require 'rails_helper'

RSpec.describe Reply, type: :model do
  it { should belong_to(:sendee) }
  it { should belong_to(:sub_request) }
  it { should define_enum_for(:value) }

  it { should validate_presence_of(:sendee_id) }
  it { should validate_presence_of(:sub_request_id) }

  startdatetime = Faker::Time.forward(23, :morning)
  enddatetime = Faker::Time.forward(23, :morning)

  let!(:my_user) { User.create(staff_id_mb: 100000164, first_name: 'Jennifer', last_name: 'Anderson')}
  let!(:my_group) { Group.create(name: 'Yoga') }
  let!(:my_sub_request) { SubRequest.create(user_id: my_user.id, group_id: my_group.id, start_date_time: startdatetime, end_date_time: enddatetime, class_name: 'Vinyasa Yoga', class_id_mb: 1000, note: 'Please cover me')}
  let!(:my_sendee) { Sendee.create(sub_request_id: my_sub_request.id, user_id: my_user.id, sub: false) }

  let!(:my_reply) { Reply.create(sendee_id: my_sendee.id, sub_request_id: my_sub_request.id, value: "maybe", note: 'I\'ll get back to you once I confirm with my other job!') }

  describe "attributes" do
     it "has sendee_id, sub_request_id, value, note" do
      expect(my_reply).to have_attributes(sendee_id: my_sendee.id, sub_request_id: my_sub_request.id, value: "maybe", note: 'I\'ll get back to you once I confirm with my other job!')
    end
  end


  describe "default values" do
     it "sets value to 0 (no_reply) if no value is specified" do
        reply = Reply.create(sendee_id: my_sendee.id, sub_request_id: my_sub_request.id)
        expect(reply.value).to eq("no_reply")
     end
  end

end
