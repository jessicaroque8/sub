require 'MindBodyAPI'

class UsersController < ApplicationController

   include Response
   include ExceptionHandler

   before_action :set_user, only: [:show, :update, :destroy]

   def index
      @users = User.all
      json_response(@users)
   end

   def create
      # Instantiate the MindBodyAPI service
      mb = MindBodyAPI.new
      # Return a hash of MINDBODY's data for the user
      @mb_data = mb.get_single_staff(params[:username], params[:password], params[:siteids], params[:first_name], params[:last_name])

      @user = User.create!(staff_id_mb: @mb_data['id'], first_name: @mb_data['first_name'], last_name: @mb_data['last_name'])
      json_response(@user, :created)
   end

   def show
      json_response(@user)
   end

   def update
      @user.update(user_params)
      head :no_content
   end

   def destroy
      @user.destroy
      head :no_content
   end

   private

   def user_params
      params.permit(:staff_id_mb, :first_name, :last_name)
   end

   def set_user
      @user = User.find(params[:id])
   end

end
