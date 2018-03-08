require 'rails_helper'

RSpec.describe "SelectedSubs", type: :request do
  describe "GET /selected_subs" do
    it "works! (now write some real specs)" do
      get selected_subs_path
      expect(response).to have_http_status(200)
    end
  end
end
