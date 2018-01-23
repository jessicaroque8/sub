require 'rails_helper'

RSpec.describe 'SubRequests API', type: :request do
   let(:my_user) { User.create(staff_id_mb: 100000315, first_name: 'Erin', last_name: 'Coffey')}
   let(:my_group) { Group.create(name: 'Yoga') }

   startdatetime = Faker::Time.forward(23, :morning)
   enddatetime = Faker::Time.forward(23, :morning)
   let!(:my_sub_request) { SubRequest.create(user_id: my_user.id, group_id: my_group.id, class_id_mb: 2342, start_date_time: startdatetime, end_date_time: enddatetime, class_name: 'Bikram Yoga', note: 'Please sub me!') }
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
      otherstartdatetime = Faker::Time.forward(24, :morning)
      otherenddatetime = Faker::Time.forward(24, :morning)
      another_user = User.create(staff_id_mb: 100000316, first_name: 'Sasha', last_name: 'Fierce')
      another_group = Group.create(name: 'Fitness')
      valid_attributes = { user_id: another_user.id, group_id: another_group.id, class_id_mb: 2342, start_date_time: otherstartdatetime, end_date_time: otherenddatetime, class_name: 'Heated Yoga', note: 'Please sub me!' }

      invalid_attributes = { user_id: another_user.id, group_id: another_group.id, start_date_time: otherstartdatetime, end_date_time: otherenddatetime, class_name: 'Heated Yoga', note: 'Please sub me!' }

      context 'when the request is valid' do
         before { post '/sub_requests', params: valid_attributes }

         it 'creates a SubRequest' do
            expect(json['user_id']).to eq(another_user.id)
            expect(json['group_id']).to eq(another_group.id)
            expect(json['start_date_time']).to eq(otherstartdatetime)
            expect(json['end_date_time']).to eq(otherenddatetime)
            expect(json['class_name']).to eq('Heated Yoga')
            expect(json['class_id_mb']).to eq(2342)
            expect(json['note']).to eq('Please sub me!')
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
      otherstartdatetime = Faker::Time.forward(24, :morning)
      otherenddatetime = Faker::Time.forward(24, :morning)
      another_user = User.create(staff_id_mb: 100000316, first_name: 'Sasha', last_name: 'Fierce')
      another_group = Group.create(name: 'Fitness')
      valid_attributes = { user_id: another_user.id, group_id: another_group.id, class_id_mb: 2342, start_date_time: otherstartdatetime, end_date_time: otherenddatetime, class_name: 'Heated Yoga', note: 'Please sub me!' }

      invalid_attributes = { user_id: another_user.id, group_id: another_group.id, start_date_time: otherstartdatetime, end_date_time: otherenddatetime, class_name: 'Heated Yoga', note: 'Please sub me!' }

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

   describe "POST /search_classes" do
      jennifer_id = 100000164
      startdatetime = DateTime.new(2018, 01, 25, 00, 00, 0)
      enddatetime = DateTime.new(2018, 01, 26, 00, 00, 0)
      it "has http status success" do
         post '/search_classes', params: { filters: { staff_id_mb: jennifer_id, start_date_time: startdatetime, end_date_time: enddatetime } }
         expect(response).to have_http_status(:success)
      end

      it "has the the right keys" do
         post '/search_classes', params: { filters: { staff_id_mb: jennifer_id, start_date_time: startdatetime, end_date_time: enddatetime } }
         expect([json][0]['class_id_mb']).to eq(2224)
         expect([json][0]['staff_name']).to eq('Jennifer Anderson')
      end
   end

end
