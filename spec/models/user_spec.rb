require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_and_belong_to_many(:groups) }
  it { should have_many(:sub_requests).through(:sendees) }
  it { should have_many(:responses).through(:sendees) }
end
