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
      # Instantiate the MindBodyAPI service
      mb = MindBodyAPI.new
      # Return a hash of MINDBODY's data for the sub_request
      @mb_data = mb.get_single_staff(params[:sub_requestname], params[:password], params[:siteids], params[:first_name], params[:last_name])

      @sub_request = SubRequest.create!(staff_id_mb: @mb_data['id'], first_name: @mb_data['first_name'], last_name: @mb_data['last_name'])
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

   private

   def sub_request_params
      params.permit(:staff_id_mb, :first_name, :last_name)
   end

   def set_sub_request
      @sub_request = SubRequest.find(params[:id])
   end

end
