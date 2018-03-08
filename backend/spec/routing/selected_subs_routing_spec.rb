require "rails_helper"

RSpec.describe SelectedSubsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/selected_subs").to route_to("selected_subs#index")
    end


    it "routes to #show" do
      expect(:get => "/selected_subs/1").to route_to("selected_subs#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/selected_subs").to route_to("selected_subs#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/selected_subs/1").to route_to("selected_subs#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/selected_subs/1").to route_to("selected_subs#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/selected_subs/1").to route_to("selected_subs#destroy", :id => "1")
    end

  end
end
