require 'rails_helper'

RSpec.describe 'Sendees API', type: :request do
   let(:my_user) { User.create(staff_id_mb: 100000315, first_name: 'Erin', last_name: 'Coffey', email: 'erin@email.com', password: 'abc123', password_confirmation: 'abc123')}
   let(:my_group) { Group.create(name: 'Yoga') }

   startdatetime = Faker::Time.forward(23, :morning)
   enddatetime = Faker::Time.forward(23, :morning)
   let!(:my_sub_request) { SubRequest.create(user_id: my_user.id, group_id: my_group.id, class_id_mb: 2342, start_date_time: startdatetime, end_date_time: enddatetime, class_name: 'Bikram Yoga', note: 'Please sub me!') }
   let(:my_sub_request_id) { my_sub_request.id.to_s}

   let!(:my_sendee) { Sendee.create(user_id: my_user.id, sub_request_id: my_sub_request.id) }
   let(:my_sendee_id) { my_sendee.id.to_s }

   let(:url) { '/sub_requests/' + my_sub_request_id + '/sendees/' + my_sendee_id }

   describe "GET /sub_requests/:sub_request_id/sendees/:id" do
      context "when the record exists" do
         before { get url }

         it "returns the sendee" do
            expect(json).not_to be_empty
            expect(json['id']).to eq(my_sendee_id)
         end

         it 'returns status code 200' do
            expect(response).to have_http_status(200)
         end
      end

      context "when the record does not exist" do
         let(:bad_url) { "/sub_requests/" + my_sub_request_id + "/sendees/" + 0.to_s }
         before { get bad_url }

         it 'returns status code 404' do
            expect(response).to have_http_status(404)
         end

         it 'returns a not found message' do
            expect(response.body).to match (/Couldn't find Sendee with 'id'=0/)
         end
      end
   end

   describe 'POST /sub_requests/:sub_request_id/sendees' do

      context 'when the request is valid' do

         it "increases the number of Sendee by 1" do
            expect { post "/sub_requests/1/sendees/", params: {sendee: {user_id: my_user.id, sub_request_id: my_sub_request.id }} }.to change(Sendee,:count).by(1)
         end

         it 'assigns the new sendee to @sendee' do
            post "/sub_requests/1/sendees/", params: {sendee: { user_id: my_user.id, sub_request_id: my_sub_request.id } }

            expect(assigns(:sendee)).to eq(Sendee.last)
         end

         it 'returns status code 201' do
            post "/sub_requests/1/sendees/", params: {sendee: { user_id: my_user.id, sub_request_id: my_sub_request.id } }

            expect(response).to have_http_status(201)
         end
      end

      context 'when the request is invalid' do

         it 'returns status code 422' do
            post "/sub_requests/1/sendees/", params: {sendee: { sub_request_id: my_sub_request.id } }
            expect(response).to have_http_status(422)
         end

         it 'returns a validation failure message' do
            post "/sub_requests/1/sendees/", params: {sendee: { sub_request_id: my_sub_request.id } }
            expect(response.body).to match(/Validation failed: User must exist/)
         end
      end
   end

   describe 'PUT /sub_requests/1/sendees/1' do
      context 'when the record exists' do
         before { put '/sub_requests/1/sendees/1', params: {sendee: {user_id: my_user.id, sub_request_id: my_sub_request.id } } }

         it "updates the record" do
            put '/sub_requests/1/sendees/1', params: {sendee: { id: my_sendee.id, sendee: {user_id: my_user.id, sub_request_id: my_sub_request.id } } }

            updated_sendee = assigns(:sendee)

            expect(updated_sendee.id).to eq my_sendee.id
            expect(updated_sendee.user_id).to eq my_sendee.user_id
            expect(updated_sendee.sub_request_id).to eq my_sendee.sub_request_id
         end

         it 'returns an empty body' do
            put '/sub_requests/1/sendees/1', params: {sendee: { id: my_sendee.id, sendee: {user_id: my_user.id, sub_request_id: my_sub_request.id } } }
            expect(response.body).to be_empty
         end

         it 'returns status code 204' do
            put '/sub_requests/1/sendees/1', params: {sendee: { id: my_sendee.id, sendee: {user_id: my_user.id, sub_request_id: my_sub_request.id } } }
            expect(response).to have_http_status(204)
         end
      end
   end

#       context "if designating a @sendee as the sub" do
#          let(:before_sub) { my_sendee.sub }
#          let(:before_confirmed) { my_sendee.confirmed}
#
#          it 'sets @sendee.confirmed as false' do
#             put '/sub_requests/1/sendees/1', params: { id: my_sendee.id, sendee: {user_id: my_user.id, sub_request_id: my_sub_request.id } }
#             my_sendee.reload
#
#             after_sub = my_sendee.sub
#             after_confirmed = my_sendee.confirmed
#
#             expect(before_sub).to eq(false)
#             expect(after_sub).to eq(true)
#             expect(before_confirmed).to eq(nil)
#             expect(after_confirmed).to eq(false)
#          end
#       end
#
#       context "if removing @sendee as the sub" do
#          before { put '/sub_requests/1/sendees/1', params: { id: my_sendee.id, sendee: {user_id: my_user.id, sub_request_id: my_sub_request.id } }
# }
#          let(:before_sub) { my_sendee.sub }
#          let(:before_confirmed) { my_sendee.confirmed }
#
#          it 'sets @sendee.confirmed as nil' do
#             put '/sub_requests/1/sendees/1', params: { id: my_sendee.id, sendee: {user_id: my_user.id, sub_request_id: my_sub_request.id } }
#             my_sendee.reload
#
#             after_sub = my_sendee.sub
#             after_confirmed = my_sendee.confirmed
#
#             expect(before_sub).to eq(true)
#             expect(after_sub).to eq(false)
#             expect(before_confirmed).to eq(false)
#             expect(after_confirmed).to eq(nil)
#          end
#       end
#    end

   describe 'DELETE /sub_requests/1/sendees/1' do

      context 'when the record exists' do
         before { delete '/sub_requests/1/sendees/1' }

         it 'returns status code 204' do
            expect(response).to have_http_status(204)
         end

         it 'deletes the Sendee' do
            delete '/sub_requests/1/sendees/1'
            count = Sendee.where({id: my_sendee.id}).size
            expect(count).to eq(0)
         end
      end
   end

end
