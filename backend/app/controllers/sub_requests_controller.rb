require 'MindBodyAPI'

class SubRequestsController < ApplicationController

   include Response
   include ExceptionHandler

   before_action :set_sub_request, only: [:show, :update, :destroy]
   before_action :authenticate_user!

   def index
      if params[:view] == 'unresolved_sent'
         @requests = SubRequest.where(user: current_user).unresolved
         serializer = SubRequestUnresolvedSerializer
      elsif params[:view] == 'unresolved_incoming'
         @requests = SubRequest.joins(:sendees).where('sendees.user_id = ?', current_user.id).unresolved
         serializer = SubRequestUnresolvedSerializer
      elsif params[:view] == 'resolved_sent'
         @requests = SubRequest.where(user: current_user).resolved
         serializer = SubRequestSerializer
      elsif params[:view] == 'resolved_incoming'
         @requests = SubRequest.joins(:sendees).where('sendees.user_id = ?', current_user.id).resolved
         serializer = SubRequestSerializer
      end

      json_response(@requests, serializer)
   end

   def create
      @sub_request = SubRequest.create!(sub_request_params)
      json_response(@sub_request, SubRequestSerializer, :created)
   end

   def show
      json_response(@sub_request, SubRequestSerializer)
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
      json_response(@staff_classes, nil)
   end

   private

   def sub_request_params
      params.permit(:view, :user_id, :group_id, :class_id_mb, :start_date_time, :end_date_time, :class_name, :note)
   end

   def staff_classes_params
      params.require(:filters).permit(:staff_id_mb, :start_date_time, :end_date_time)
   end

   def set_sub_request
      @sub_request = SubRequest.find(params[:id])
   end

end
