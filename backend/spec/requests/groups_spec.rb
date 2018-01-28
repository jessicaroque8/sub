require 'rails_helper'

RSpec.describe 'Groups API', type: :request do
   let!(:group) { Group.create(name: 'Vinyasa Yoga') }
   let(:group_id) { group.id }
   let(:url) { '/groups/' + group_id.to_s }
   let(:user) {User.create(first_name: 'Lakshmi', last_name: 'Ganesha', email: 'test@email.com', password: 'abc12345', password_confirmation: 'abc12345')}

   describe "GET /groups" do
      before { get '/groups' }

      it "returns groups" do
         expect(json).not_to be_empty
         expect(json.size).to eq(1)
      end

      it 'returns status code 200' do
         expect(response).to have_http_status(200)
      end
   end

   describe "GET /groups/:id" do
      context "when the record exists" do
         before { get url }

         it "returns the group" do
            expect(json).not_to be_empty
            expect(json['id']).to eq(group.id)
         end

         it 'returns status code 200' do
            expect(response).to have_http_status(200)
         end
      end

      context "when the record does not exist" do
         bad_url = '/groups/' + 5.to_s
         before { get bad_url }

         it 'returns status code 404' do
            expect(response).to have_http_status(404)
         end

         it 'returns a not found message' do
            expect(response.body).to match (/Couldn't find Group/)
         end
      end
   end

   describe 'POST /groups' do
      valid_attributes = { name: 'Heated Yoga' }

      context 'when the request is valid' do
         before { post '/groups', params: valid_attributes }

         it 'creates a group' do
            expect(json['name']).to eq('Heated Yoga')
         end

         it 'returns status code 201' do
            expect(response).to have_http_status(201)
         end
      end

      context 'when the request is invalid' do
         before { post '/groups' }

         it 'returns status code 422' do
            expect(response).to have_http_status(422)
         end

         it 'returns a validation failure message' do
            expect(response.body).to match(/Validation failed: Name can't be blank/)
         end
      end
   end

   describe 'PUT /groups/:id' do
      valid_attributes = { name: 'Pilates' }

      context 'when the record exists' do
         before { put '/groups/1', params: valid_attributes }

         it 'updates the record' do
            expect(response.body).to be_empty
         end

         it 'returns status code 204' do
            expect(response).to have_http_status(204)
         end
      end
   end

   describe 'DELETE /groups/:id' do
      valid_attributes = { name: 'Pilates' }

      context 'when the record exists' do
         before { delete '/groups/1' }

         it 'returns status code 204' do
            expect(response).to have_http_status(204)
         end
      end
   end



end
