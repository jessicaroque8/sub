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
         startdatetime = DateTime.new(2018, 01, 28, 00, 00, 0)
         enddatetime = DateTime.new(2018, 01, 29, 00, 00, 0)
         it "returns a hash of class/es" do
            mb = MindBodyAPI.new
            filters = { staff_id_mb: jennifer_id, start_date_time: startdatetime, end_date_time: enddatetime }
            jennifer_classes = mb.get_staff_classes(filters)

            expect(jennifer_classes).to be_an_instance_of(Hash)
         end

         it "returns classes with the same startdatetime as entered in the parameters" do
            mb = MindBodyAPI.new
            filters = { staff_id_mb: jennifer_id, start_date_time: startdatetime, end_date_time: enddatetime }
            jennifer_classes = mb.get_staff_classes(filters)
            input_startdate = filters[:start_date_time].to_date
            output_startdate = jennifer_classes[1]['start_date_time'].to_date

            expect(output_startdate).to eq(input_startdate)
         end
      end
   end

   context "valid arguments" do
      describe "#get_classes_by_id" do
         it "returns the classes" do
            mb = MindBodyAPI.new
            jennifer_id = 100000164
            startdatetime = DateTime.new(2018, 01, 24, 07, 00, 0)
            enddatetime = DateTime.new(2018, 01, 24, 07, 45, 0)
            classes = mb.get_classes_by_id(2261)

            expect(classes).to eq({1=>{"class_id_mb"=>2261, "staff_name"=>"Jennifer Anderson", "staff_id"=>100000164, "class_name"=>"Pilates 101", "start_date_time"=>startdatetime, "end_date_time"=>enddatetime}})
         end
      end
   end

   # context "valid arguments" do
   #    describe "#sub_class_teacher" do
   #       mb = MindBodyAPI.new
   #       jennifer_id = 100000164
   #       startdatetime = DateTime.new(2018, 01, 27, 00, 00, 0)
   #       enddatetime = DateTime.new(2018, 01, 28, 00, 00, 0)
   #       filters = { staff_id_mb: jennifer_id, start_date_time: startdatetime, end_date_time: enddatetime }
   #       jennifer_classes = mb.get_staff_classes(filters)
   #       let(:class_id) { 2261 }
   #       let(:before_class) { jennifer_classes[2] }
   #
   #       let(:johnny_sub) { mb.get_single_staff('hi', 'hi', '-99', 'Johnny', 'Salke') }
   #       let(:johnny_id) { 100000270 }
   #
   #       it "changes the class's teacher to the sub" do
   #          starttime = DateTime.new(2018, 01, 27, 07, 0, 00, 0)
   #          endtime = DateTime.new(2018, 01, 27, 07, 45, 00, 0)
   #          expect(before_class).to eq( {"class_id_mb"=>2261, "staff_name"=>"Jennifer Anderson", "staff_id"=>100000164, "class_name"=>"Pilates 101", "start_date_time"=> starttime, "end_date_time"=> endtime} )
   #
   #          mb.sub_class_teacher(jennifer_classes[2]['class_id'], johnny_id)
   #
   #          after_class = mb.get_single_class(jennifer_classes[2]['class_id'])
   #
   #          expect(after_class['staff_id']).to eq(johnny_id)
   #       end
   #    end
   # end

end
