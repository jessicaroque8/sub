require 'rails_helper'
require 'MindBodyAPI'

RSpec.describe MindBodyAPI do

   my_sourcekey = '_Blocstudent'
   my_password = 'gS2EOansqkwV/jHxPbBtCuf0iH0='
   my_siteids = -99
   my_first_name = 'Erin'
   my_last_name = 'Coffey'

   context "valid arguments" do
      describe "#get_all_staff" do
         it "returns an array of all staff members" do
            mindbodyapi = MindBodyAPI.new
            all_staff = mindbodyapi.get_all_staff(source_key = my_sourcekey, password = my_password, siteids = {'ids' => [my_siteids]})

            expect(all_staff).to be_an_instance_of(Array)
            expect(all_staff.size).to be > 0
         end
      end
   end

   context "invalid arguments" do
   end

   context "valid arguments" do
      describe "#get_single_staff" do
         it "returns a hash of the specified staff's info" do
            mindbodyapi = MindBodyAPI.new
            single_staff = mindbodyapi.get_single_staff(my_sourcekey, my_password, my_siteids, my_first_name, my_last_name)

            expect(single_staff).to be_an_instance_of(Hash)
            expect(single_staff['id']).to eq(100000315)
            expect(single_staff['first_name']).to eq(my_first_name)
            expect(single_staff['last_name']).to eq( my_last_name)
            # expect(single_staff['email']).to be nil
            # expect(single_staff['mobile_phone']).to be nil
            # expect(single_staff['home_phone']).to be nil
            # expect(single_staff['work_phone]']).to be nil
            # expect(single_staff['login_locations']).to eq([])
         end
      end
   end

   context "invalid arguments" do
   end

end
