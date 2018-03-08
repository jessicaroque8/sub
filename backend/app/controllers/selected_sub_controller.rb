class SelectedSubController < ApplicationController

   include Response
   include ExceptionHandler
   
  before_action :set_selected_sub, only: [:show, :update, :destroy]

  # GET /selected_subs
  def index
    @selected_subs = SelectedSub.all

    json_response(@selected_subs, SelectedSubSerializer, :created)
  end

  # GET /selected_subs/1
  def show
     json_response(@selected_sub, SelectedSubSerializer)
  end

  # POST /selected_subs
  def create
    @selected_sub = SelectedSub.create(selected_sub_params)

    if @selected_sub.save
      json_response(@selected_sub, SelectedSubSerializer, :created)
    else
      render json: @selected_sub
    end
  end

  # PATCH/PUT /selected_subs/1
  def update
    if @selected_sub.update(selected_sub_params)
      json_response(@selected_sub, SelectedSubSerializer)
    end
  end

  # DELETE /selected_subs/1
  def destroy
    @selected_sub.destroy
  end

  private
    def set_selected_sub
      @selected_sub = SelectedSub.find(params[:id])
    end

    def selected_sub_params
      params.require(:selected_sub).permit(:id, :confirmed, :sub_request_id, :sendee_id)
    end
end
