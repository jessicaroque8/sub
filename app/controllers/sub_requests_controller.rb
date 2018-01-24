require 'MindBodyAPI'

class SubRequestsController < ApplicationController

   include Response
   include ExceptionHandler

   before_action :set_sub_request, only: [:show, :update, :destroy]

   def index
      @sub_requests = SubRequest.all
      json_response(@sub_requests)
   end

   def create
      @sub_request = SubRequest.create!(sub_request_params)
      json_response(@sub_request, :created)
   end

   def show
      json_response(@sub_request)
   end

   def update
      @sub_request.update(sub_request_params)
      head :no_content
   end

   def destroy
      @sub_request.destroy
      head :no_content
   end

# Method: search_classes
# Returns a JSON object containing one or more classes with the following attributes: class_id_mb, staff_name, staff_id, class_name, start_date_time, end_date_time
   def search_classes
      mb = MindBodyAPI.new
      @staff_classes = mb.get_staff_classes(staff_classes_params)
      render :json => @staff_classes
   end

   def send_to_sendees
      @sub_request = SubRequest.find(params[:sub_request_id])
      @group = Group.find(@sub_request.group_id)
      @sendees = {}
      @group.users.each_with_index do |sendee, index|
         @sendees[index] = Sendee.create!(user: sendee, sub_request: @sub_request, sub: false)
      end
      render :json => @sendees
   end

   private

   def sub_request_params
      params.permit(:user_id, :group_id, :class_id_mb, :start_date_time, :end_date_time, :class_name, :note)
   end

   def staff_classes_params
      params.require(:filters).permit(:staff_id_mb, :start_date_time, :end_date_time)
   end

   def set_sub_request
      @sub_request = SubRequest.find(params[:id])
   end

end
