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
      @mb_data = mb.get_single_staff(params[:mb_username], params[:mb_password], params[:mb_siteids], params[:first_name], params[:last_name])
      byebug
      @user = User.create!(
         staff_id_mb: @mb_data['id'],
         first_name: @mb_data['first_name'],
         last_name: @mb_data['last_name'],
         email: params[:email],
         password: params[:password],
         password_confirmation: params[:password_confirmation]
      )
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

   def mb_source_credentials
      params.permit(:mb_username, :mb_password, :mb_siteids)
   end

   def user_params
      params.permit(:staff_id_mb, :first_name, :last_name, :email, :password, :password_confirmation)
   end

   def set_user
      @user = User.find(params[:id])
   end

end
