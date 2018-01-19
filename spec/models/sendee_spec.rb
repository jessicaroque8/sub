require 'rails_helper'

RSpec.describe Sendee, type: :model do
   it { should belong_to(:sub_request) }
   it { should belong_to(:user) }
   it { should have_one(:response) }
end
