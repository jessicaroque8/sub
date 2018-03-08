class SendeesController < ApplicationController

   include Response
   include ExceptionHandler

   before_action :set_sendee, only: [:show, :update, :destroy]

   def index
      @sendees = Sendee.where(sub_request_id: params[:sub_request_id])
      json_response(@sendees, SendeeSerializer)
   end

  def create
     @sendee = Sendee.create(sendee_params)
     json_response(@sendee, SendeeSerializer, :created)
  end

  def show
     json_response(@sendee, SendeeSerializer)
  end

  def update
     # before_sub_val = @sendee.sub
     # before_confirmed_val = @sendee.confirmed

     @sendee.update!(sendee_params)

     # after_sub_val = @sendee.sub
     # after_confirmed_val = @sendee.confirmed
     #
     # if before_sub_val == false && after_sub_val == true
     #    @sendee.confirmed = false
     #    @sendee.save!
     #
     #    @sendee.sub_request.awaiting_confirm = true
     #    @sendee.sub_request.save!
     # elsif before_sub_val == true && after_sub_val == false
     #    @sendee.confirmed = nil
     #    @sendee.save!
     #    @sendee.sub_request.awaiting_confirm = false
     #    @sendee.sub_request.save!
     # elsif before_sub_val == true && after_confirmed_val == true
     #    @sendee.sub_request.closed = true
     #    @sendee.sub_request.save!
     # end

     head :no_content
  end

  def destroy
     @sendee.destroy
     head :no_content
  end

  private

  def sendee_params
     params.require(:sendee).permit(:user_id, :sub_request_id)
  end

  def set_sendee
     @sendee = Sendee.find(params[:id])
  end
end
