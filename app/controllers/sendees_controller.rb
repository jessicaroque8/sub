class SendeesController < ApplicationController

   include Response
   include ExceptionHandler

   before_action :set_sendee, only: [:show, :update, :destroy]

  def create
     @sendee = Sendee.create!(sendee_params)
     json_response(@sendee, :created)
  end

  def show
     json_response(@sendee)
  end

  def update
     @sendee.update(sendee_params)
     head :no_content
  end

  def destroy
     @sendee.destroy
     head :no_content
  end

  private

  def sendee_params
     params.permit(:user_id, :sub_request_id, :sub)
  end

  def set_sendee
     @sendee = Sendee.find(params[:id])
  end
end
