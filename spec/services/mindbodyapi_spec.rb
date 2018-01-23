require 'rails_helper'
require 'MindBodyAPI'

RSpec.describe MindBodyAPI do

   my_sourcekey = 'erincoffey'
   my_password = 'abc123'
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
         end
      end
   end

   context "invalid arguments" do
   end

   context "valid arguments" do
      describe "#get_staff_classes" do
         jennifer_id = 100000164
         it "returns a hash of class/es" do
            mb = MindBodyAPI.new
            filters = { filters: { staff_id_mb: jennifer_id, start_date_time: DateTime.new(2018, 01, 26, 00, 00, 0), end_date_time: DateTime.new(2018, 01, 27, 00, 00, 0) } }
            jennifer_classes = mb.get_staff_classes(filters)

            expect(jennifer_classes).to be_an_instance_of(Hash)
         end

         it "returns classes with the same startdatetime as entered in the parameters" do
            mb = MindBodyAPI.new
            filters = { filters: { staff_id_mb: 100000164, start_date_time: DateTime.new(2018, 01, 26, 00, 00, 0), end_date_time: DateTime.new(2018, 01, 27, 00, 00, 0) } }
            jennifer_classes = mb.get_staff_classes(filters)
            input_startdate = filters[:filters][:start_date_time].to_date
            output_startdate = jennifer_classes[1]['start_date_time'].to_date

            expect(output_startdate).to eq(input_startdate)
         end
      end
   end

end
