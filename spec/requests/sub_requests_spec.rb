require 'rails_helper'

RSpec.describe 'SubRequests API', type: :request do
   let(:my_user) { User.create(staff_id_mb: 100000315, first_name: 'Erin', last_name: 'Coffey')}
   let(:my_group) { Group.create(name: 'Yoga') }

   datetime = Faker::Time.forward(23, :morning)
   let!(:my_sub_request) { SubRequest.create(user_id: my_user.id, group_id: my_group.id, datetime: datetime, class_name: 'Vinyasa Yoga', class_id_mb: 1000, note: 'Please cover me')}
   let(:url) { '/sub_requests/' + my_sub_request.id.to_s }

   describe "GET /sub_requests" do
      before { get '/sub_requests' }

      it "returns sub requests" do
         expect(json).not_to be_empty
         expect(json.size).to eq(1)
      end

      it 'returns status code 200' do
         expect(response).to have_http_status(200)
      end
   end

   describe "GET /sub_requests/:id" do
      context "when the record exists" do
         before { get url }

         it "returns the user" do
            expect(json).not_to be_empty
            expect(json['id']).to eq(my_user.id)
         end

         it 'returns status code 200' do
            expect(response).to have_http_status(200)
         end
      end

      context "when the record does not exist" do
         bad_url = '/sub_requests/' + 0.to_s
         before { get bad_url }

         it 'returns status code 404' do
            expect(response).to have_http_status(404)
         end

         it 'returns a not found message' do
            expect(response.body).to match (/Couldn't find SubRequest with 'id'=0/)
         end
      end
   end

   describe 'POST /sub_requests' do
      my_datetime = Faker::Time.forward(24, :morning)
      another_user = User.create(staff_id_mb: 100000316, first_name: 'Sasha', last_name: 'Fierce')
      another_group = Group.create(name: 'Fitness')
      valid_attributes = { user_id: another_user.id, group_id: another_group.id, datetime: my_datetime, class_name: 'Zumba', class_id_mb: 1001, note: 'Please cover me' }

      invalid_attributes = { user_id: another_user.id, group_id: another_group.id, datetime: my_datetime, class_name: 'Zumba', class_id_mb: nil, note: 'Please cover me' }

      context 'when the request is valid' do
         before { post '/sub_requests', params: valid_attributes }

         it 'retrieves from the MINDBODY API the class data' do
            expect(assigns(:mb_class_data)).not_to be_nil
            expect(assigns(:mb_class_data)).to be_an_instance_of(Hash)
         end

         it 'creates a SubRequest using the data from MINDBODY' do
            expect(json['user_id']).to eq(my_user.id)
            expect(json['group_id']).to eq(my_group.id)
            expect(json['datetime']).to eq(my_datetime)
            expect(json['class_name']).to eq('Vinyasa Yoga')
            expect(json['class_id_mb']).to eq(1001)
            expect(json['note']).to eq('Please cover me')
         end

         it 'returns status code 201' do
            expect(response).to have_http_status(201)
         end
      end

      context 'when the request is invalid' do
         before { post '/sub_requests', params: invalid_attributes }

         it 'returns status code 422' do
            expect(response).to have_http_status(422)
         end

         it 'returns a validation failure message' do
            expect(response.body).to match(/Validation failed: Class id mb can't be blank/)
         end
      end
   end

   describe 'PUT /sub_requests/:id' do
      my_datetime = Faker::Time.forward(24, :morning)
      another_user = User.create(staff_id_mb: 100000316, first_name: 'Sasha', last_name: 'Fierce')
      another_group = Group.create(name: 'Fitness')
      valid_attributes = { user_id: another_user.id, group_id: another_group.id, datetime: my_datetime, class_name: 'Zumba', class_id_mb: 1001, note: 'Please cover me' }

      invalid_attributes = { user_id: another_user.id, group_id: another_group.id, datetime: my_datetime, class_name: 'Zumba', class_id_mb: nil, note: 'Please cover me' }

      context 'when the record exists' do
         before { put url, params: valid_attributes }

         it 'updates the record' do
            expect(response.body).to be_empty
         end

         it 'returns status code 204' do
            expect(response).to have_http_status(204)
         end
      end

   end

   describe 'DELETE /users/:id' do
      context 'when the record exists' do
         before { delete url }

         it 'returns status code 204' do
            expect(response).to have_http_status(204)
         end
      end
   end

end
