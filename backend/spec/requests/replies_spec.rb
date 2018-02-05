require 'rails_helper'

RSpec.describe 'Replies API', type: :request do
   let(:user) { User.create(staff_id_mb: 100000315, first_name: 'Erin', last_name: 'Coffey', email: 'erin@email.com', password: 'abc123', password_confirmation: 'abc123')}
   let(:my_group) { Group.create(name: 'Yoga') }

   startdatetime = Faker::Time.forward(23, :morning)
   enddatetime = Faker::Time.forward(23, :morning)
   let!(:my_sub_request) { SubRequest.create(user_id: user.id, group_id: my_group.id, class_id_mb: 2342, start_date_time: startdatetime, end_date_time: enddatetime, class_name: 'Bikram Yoga', note: 'Please sub me!') }
   let!(:my_sendee) { Sendee.create(user_id: user.id, sub_request_id: my_sub_request.id, sub: false) }

   let!(:my_reply) { my_sendee.reply }

   let(:url) { "/sub_requests/" + my_sub_request.id.to_s + "/sendees/" + my_sendee.id.to_s + '/replies/' + my_reply.id.to_s }

   describe "GET /sub_requests/:sub_request_id/sendees/:sendee_id/replies/:id" do
      context "when the record exists" do
         before { get '/sub_requests/1/sendees/1/replies/1' }

         it "returns the reply" do
            expect(json).not_to be_empty
            expect(json['id']).to eq(my_reply.id)
         end

         it 'returns status code 200' do
            expect(response).to have_http_status(200)
         end
      end

      context "when the record does not exist" do
         let(:bad_url) { "/sub_requests/1/sendees/1/replies/" + 0.to_s }
         before { get bad_url }

         it 'returns status code 404' do
            expect(response).to have_http_status(404)
         end

         it 'returns a not found message' do
            expect(response.body).to match (/Couldn't find Reply with 'id'=0/)
         end
      end
   end

   describe 'POST /sub_requests/:sub_request_id/sendees/:sendee_id/replies/:id' do

      context 'when the request is valid' do

         it "increases the number of Reply by 1" do
            expect { post "/sub_requests/1/sendees/1/replies", params: {sendee_id: my_sendee.id, sub_request_id: my_sub_request.id, value: "agree", note: 'Happy to sub this!' } }.to change(Reply,:count).by(1)
         end

         it 'assigns the new reply to @reply' do
            post "/sub_requests/1/sendees/1/replies", params: { sendee_id: my_sendee.id, sub_request_id: my_sub_request.id, value: "agree", note: 'Happy to sub this!' }

            expect(assigns(:reply)).to eq(Reply.last)
         end

         it 'returns status code 201' do
            post "/sub_requests/1/sendees/1/replies", params: { sendee_id: my_sendee.id, sub_request_id: my_sub_request.id, value: "agree", note: 'Happy to sub this!' }

            expect(response).to have_http_status(201)
         end
      end
   end

   describe 'PUT /sub_requests/1/sendees/1' do
      context 'when the record exists' do
         before { put '/sub_requests/1/sendees/1/replies/1', params: {sendee_id: my_sendee.id, sub_request_id: my_sub_request.id, value: "agree" } }

         it "updates the record" do
            updated_reply = assigns(:reply)

            expect(updated_reply.id).to eq my_reply.id
            expect(updated_reply.sendee_id).to eq my_reply.sendee_id
            expect(updated_reply.sub_request_id).to eq my_reply.sub_request_id
            expect(updated_reply.value).to eq("agree")
         end

         it 'returns an empty body' do
            expect(response.body).to be_empty
         end

         it 'returns status code 204' do
            expect(response).to have_http_status(204)
         end
      end
   end

   describe 'DELETE /sub_requests/1/sendees/1/replies/1' do

      context 'when the record exists' do
         before { delete '/sub_requests/1/sendees/1/replies/1' }

         it 'returns status code 204' do
            expect(response).to have_http_status(204)
         end

         it 'deletes the Reply' do
            delete '/sub_requests/1/sendees/1/replies/1'
            count = Reply.where({id: my_reply.id}).size
            expect(count).to eq(0)
         end
      end
   end

end
