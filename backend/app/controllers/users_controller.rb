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
      @user = User.create!(
         staff_id_mb: params[:mb_id],
         first_name: params[:first_name],
         last_name: params[:last_name],
         email: params[:email],
         password: params[:password],
      )
      json_response(@user, UserSerializer, :created)
   end

   def show
      json_response(@user, UserSerializer)
   end

   def update
      @user.update(user_params)
      head :no_content
   end

   def destroy
      @user.destroy
      head :no_content
   end

   def link_to_mb
      @mbData = link_to_mb_params
      mb = MindBodyAPI.new
      @output_data = mb.get_single_staff(
         @mbData['email'],
         @mbData['password'],
         @mbData['first_name'],
         @mbData['last_name'],
      )

# Returns staff_id_mb, first_name, last_name, image
      json_response(@output_data)
   end

   private

   def mb_source_credentials
      params.permit(:mb_username, :mb_password, :mb_siteids)
   end

   def user_params
      params.permit(:staff_id_mb, :first_name, :last_name, :email, :password, :image)
   end

   def set_user
      @user = User.find(params[:id])
   end

   def link_to_mb_params
      params.require(:mbData).permit(:email, :password, :first_name, :last_name)
   end

end
