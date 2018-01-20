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

   # Call this method before creating a new Sub Request.
   # User should select the correct class if there are multiple array items.
   def search_classes
      mb = MindBodyAPI.new
      classes = mb.get_staff_classes(params[:staff_id_mb], params[:start_date_time], params[:end_date_time])
   end

   private

   def sub_request_params
      params.permit(:user_id, :group_id, :class_id_mb, :start_date_time, :end_date_time, :class_name, :note)
   end

   def set_sub_request
      @sub_request = SubRequest.find(params[:id])
   end

end
