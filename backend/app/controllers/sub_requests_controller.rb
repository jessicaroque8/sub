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
      end

      json_response(@requests, serializer)

      # @closed_requests = {
      #    sent: SubRequest.sent.closed,
      #    incoming: SubRequest.incoming.closed
      # }
      #
      # @past_requests = {
      #    sent: SubRequest.sent.past,
      #    incoming: SubRequest.incoming.past
      # }
      # render json: @unresolved_requests, each_serializer: SubRequestUnresolvedSerializer

      # if params[:scope] == "incomplete"
      #    user_requests = SubRequest.where('user_id = ? AND start_date_time >= ?', params[:user_id].to_i, Time.now.to_date)
      #    @sent_sub_requests = []
      #       user_requests.each do |request|
      #          complete = false
      #          request.sendees.each do |sendee|
      #             if sendee.confirmed == true
      #                complete = true
      #             end
      #          end
      #
      #          if complete == false
      #             @sent_sub_requests << request
      #          end
      #       end
      #
      #    other_requests = SubRequest.where('start_date_time >= ?', Time.now.to_date).joins(:sendees).where('sendees.user_id = ?', params[:user_id])
      #    @incoming_sub_requests = []
      #    other_requests.each do |request|
      #       complete = false
      #       request.sendees.each do |sendee|
      #          if sendee.confirmed == true
      #             complete = true
      #          end
      #       end
      #
      #       if complete == false
      #          @incoming_sub_requests << request
      #       end
      #    end
      #
      #    json_response({ :sent => @sent_sub_requests, :incoming => @incoming_sub_requests})
      # elsif params[:scope] == "complete"
      #    user_requests = SubRequest.where('user_id = ? AND start_date_time >= ?', params[:user_id].to_i, Time.now.to_date)
      #    @sent_sub_requests = []
      #
      #       user_requests.each do |request|
      #          complete = false
      #          request.sendees.each do |sendee|
      #             if sendee.confirmed == true
      #                complete = true
      #             end
      #          end
      #
      #          if complete == true
      #             @sent_sub_requests << request
      #          end
      #       end
      #
      #    other_requests = SubRequest.where('start_date_time >= ?', Time.now.to_date).joins(:sendees).where('sendees.user_id = ?', params[:user_id].to_i)
      #    @incoming_sub_requests = []
      #
      #    other_requests.each do |request|
      #       complete = false
      #       request.sendees.each do |sendee|
      #          if sendee.confirmed == true
      #             complete = true
      #          end
      #       end
      #
      #       if complete == true
      #          @incoming_sub_requests << request
      #       end
      #    end
      #
      #    json_response({ :sent => @sent_sub_requests, :incoming => @incoming_sub_requests})
      # elsif params[:scope] == "past"
      #    sent_requests = SubRequest.where('user_id = ? AND start_date_time <= ?', params[:user_id].to_i, Time.now.to_date)
      #    @sent_sub_requests = []
      #    sent_requests.each { |s| @sent_sub_requests << s }
      #
      #    incoming_requests = SubRequest.where('start_date_time <= ?', Time.now.to_date).joins(:sendees).where('sendees.user_id = ?', params[:user_id].to_i)
      #    @incoming_sub_requests = []
      #    incoming_requests.each { |s| @incoming_sub_requests << s }
      #
      #    json_response({ :sent => @sent_sub_requests, :incoming => @incoming_sub_requests})
      # end
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
