require 'rails_helper'

RSpec.describe Response, type: :model do
  it { should belong_to(:sendee) }
  it { should belong_to(:sub_request) }
end
