require 'rails_helper'

RSpec.describe 'Users API', type: :request do
   let!(:my_user) { User.create(staff_id_mb: 100000333, first_name: 'Kali', last_name: 'Shakti') }
   let(:my_user_id) { my_user.id }
   let(:url) { '/users/' + my_user_id.to_s }

   describe "GET /users" do
      before { get '/users' }

      it "returns users" do
         expect(json).not_to be_empty
         expect(json.size).to eq(1)
      end

      it 'returns status code 200' do
         expect(response).to have_http_status(200)
      end
   end

   describe "GET /users/:id" do
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
         bad_url = '/users/' + 0.to_s
         before { get bad_url }

         it 'returns status code 404' do
            expect(response).to have_http_status(404)
         end

         it 'returns a not found message' do
            expect(response.body).to match (/Couldn't find User with 'id'=0/)
         end
      end
   end

   describe 'POST /users' do
      valid_attributes = { username: 'erincoffey', password: 'abc123', siteids: '-99', first_name: 'Erin', last_name: 'Coffey' }

      invalid_attributes = { username: 'yogi1', password: 'abc1234', siteids: '-99', first_name: 'Someone', last_name: 'NoExist' }

      context 'when the request is valid' do
         before { post '/users', params: valid_attributes }

         it 'retrieves from the MINDBODY API the user data' do
            expect(assigns(:mb_data)).not_to be_nil
            expect(assigns(:mb_data)).to be_an_instance_of(Hash)
         end

         it 'creates a user using the data from MINDBODY' do
            expect(json['staff_id_mb']).to eq(100000315)
            expect(json['first_name']).to eq('Erin')
            expect(json['last_name']).to eq('Coffey')
         end

         it 'returns status code 201' do
            expect(response).to have_http_status(201)
         end
      end

      context 'when the request is invalid' do
         before { post '/users', params: invalid_attributes }

         it 'returns status code 422' do
            expect(response).to have_http_status(422)
         end

         it 'returns a validation failure message' do
            expect(response.body).to match(/Validation failed: Staff id mb can't be blank/)
         end
      end
   end

   describe 'PUT /users/:id' do
      valid_attributes = { staff_id_mb: 100000315, first_name: 'Erin', last_name: 'Coffey-Bean' }

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
      valid_attributes = { staff_id_mb: 100000315, first_name: 'Erin', last_name: 'Coffey' }

      context 'when the record exists' do
         before { delete url }

         it 'returns status code 204' do
            expect(response).to have_http_status(204)
         end
      end
   end

end
