require 'rails_helper'

RSpec.describe SelectedSub, type: :model do
  it { should belong_to(:sub_request) }
  it { should belong_to(:sendee) }

  startdatetime = Faker::Time.forward(23, :morning)
  enddatetime = Faker::Time.forward(23, :morning)
  let!(:my_user) { User.create(staff_id_mb: 100000164, first_name: 'Jennifer', last_name: 'Anderson')}
  let!(:my_group) { Group.create(name: 'Yoga') }
  let!(:my_sub_request) { SubRequest.create(user_id: my_user.id, group_id: my_group.id, start_date_time: startdatetime, end_date_time: enddatetime, class_name: 'Vinyasa Yoga', class_id_mb: 1000, note: 'Please cover me')}

  let!(:my_sendee) { Sendee.create(sub_request_id: my_sub_request.id, user_id: my_user.id) }

end
