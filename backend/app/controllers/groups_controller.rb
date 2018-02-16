class GroupsController < ApplicationController

   include Response
   include ExceptionHandler

   before_action :set_group, only: [:show, :update, :destroy]
   def index
      if params[:user_id]
         byebug
         @groups = Group.joins(:users).where('user_id = ?', params[:user_id])
      else
         byebug
         @groups = Group.all
      end

      json_response(@groups)
   end

   def create
      @group = Group.create!(group_params)
      json_response(@group, :created)
   end

   def show
      json_response(@group)
   end

   def update
      @group.update(group_params)
      head :no_content
   end

   def destroy
      @group.destroy
      head :no_content
   end

   private

   def group_params
      params.permit(:name, :user_id)
   end

   def set_group
      @group = Group.find(params[:id])
   end
end
