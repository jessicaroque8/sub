class ReplyController < ApplicationController

   include Response
   include ExceptionHandler

   before_action :set_reply, only: [:update, :destroy]


   def index
      @reply = Reply.where('sub_request_id = ? AND sendee_id = ?', params[:sub_request_id], params[:sendee_id])
   end

  def create
     @reply = Reply.create!(reply_params)
     json_response(@reply, :created)
  end

  def update
     @reply.update(reply_params)
     head :no_content
  end

  def destroy
     @reply.destroy
     head :no_content
  end

  private

  def reply_params
     params.permit(:sendee_id, :sub_request_id, :value, :note)
  end

  def set_reply
     @reply = Reply.find(params[:id])
  end
end
