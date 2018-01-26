require 'savon'

class MindBodyAPI

   def get_all_staff(source_key, password, siteids)
      # Returns a Hash of MindBody::Models::Staff.
      response = MindBody::Services::StaffService.get_staff('Username' => source_key, 'Password' => password, 'SiteIDs' => {'ids' => [siteids]})
      # Isolate the array containing each staff member's data.
      all_staff = response.result.first[1]
   end

   def get_single_staff(username, password, siteids, first_name, last_name)
      all_staff = get_all_staff(username, password, siteids)
      single_staff = {}
      all_staff.each do |staff|
         if staff['first_name'] == first_name && staff['last_name'] == last_name
            single_staff['id'] = staff['id']
            single_staff['first_name'] = staff['first_name']
            single_staff['last_name'] = staff['last_name']
         end
      end
      single_staff
   end

   # Gets a staff member's classes based on the specified parameters.
   # startdatetime and enddatetime must be DateTime objects.
   # Returns a Nested Hash.

   # filters: hash of symbols as keys and their values: :staff_id_mb, :startdatetime, :enddatetime
   # Ex: filters = {
         # 		:staff_id_mb: 100000164,
         # 		:start_date_time: DateTime.new(2018, 02, 02, 07, 45, 00),
         # 		:end_date_time: DateTime.new(2018, 02, 02, 07, 45, 00)
         # }
   def get_staff_classes(filters)
      puts filters
      response = MindBody::Services::ClassService.get_classes(
         'StaffIDs' =>
            {'ids' => filters[:staff_id_mb].to_i},
         'StartDateTime' =>
            truncate_datetime(filters[:start_date_time]),
         'EndDateTime' =>
            truncate_datetime(filters[:end_date_time]),
      )
      classes = response.result.first[1]
      staff_classes = {}

      count = 0
      classes.each do |c|
         if c['staff']['id'].to_i == filters[:staff_id_mb].to_i
            if c['start_date_time'].to_date == filters[:start_date_time].to_date
               class_data = {}
               class_data['class_id_mb'] = c['id']
               class_data['staff_name'] = c['staff']['name']
               class_data['staff_id'] = c['staff']['id']
               class_data['class_name'] = c['class_description']['name']
               class_data['start_date_time'] = c['start_date_time']
               class_data['end_date_time'] = c['end_date_time']

               staff_classes[count] = class_data
               count += 1
            end
         end
      end
      staff_classes
   end

   def get_classes_by_id(class_ids)
      response = MindBody::Services::ClassService.get_classes('ClassIDs' => {'ids' => [class_ids] } )
      classes = response.result.first[1]

      requested_classes = {}
      count = 0
      classes.each do |c|
         if c['id'].to_i == class_ids
               class_data = {}
               class_data['id'] = c['id']
               class_data['staff_name'] = c['staff']['name']
               class_data['staff_id'] = c['staff']['id']
               class_data['class_name'] = c['class_description']['name']
               class_data['start_date_time'] = c['start_date_time']
               class_data['end_date_time'] = c['end_date_time']

               requested_classes[count] = class_data
               count += 1
            end
         end
      requested_classes
   end

   def sub_class_teacher(class_id, sub_staff_id)
      client = Savon.client(wsdl: "https://api.mindbodyonline.com/0_5_1/ClassService.asmx?wsdl")
      response = client.call(:substitute_class_teacher, message: {
            "Request" => {
               "SourceCredentials" =>
                  { "SourceName" => "Blocstudent",
                     "Password" => "gS2EOansqkwV/jHxPbBtCuf0iH0=",
                     "SiteIDs" => {
                        "int" => "-99"
                     }
                  },
               "UserCredentials" =>
                  { "Username" => "Siteowner",
                     "Password" => "apitest1234",
                     "SiteIDs" => {
                        "int" => "-99"
                     },
                     "LocationID" => "1"
                  },
               "ClassID" => class_id,
               "StaffID" => sub_staff_id,
               "OverrideConflicts" => "false",
               "SendClientEmail" => "false",
               "SendOldStaffEmail" => "false",
               "SendNewStaffEmail" => "false"
            }
         })

#  Need to find out how to parse through the XML Response to extract the error code.

      # case response.code
      #    when 200
      #       puts "Successfully substituted class teacher."
      #    when 700
      #       puts "This staff member is already teaching a class at this time."
      #    else
      #       puts "There was an error when trying to substitute the class teacher."
      # end

# Return the updated class info or print error.
      updated_class = get_classes_by_id(class_id)

      if updated_class == {}
         puts 'No classes were found for that Class ID.'
      end

      updated_class
   end

   private

# Converts DateTime object to string and removes miliseconds.
# Necessary to interface with StartDateTime and EndDateTime parameters in the MINDBODY API database.
   def truncate_datetime(datetime)
      datetime.to_s.gsub('+00:00', '')
   end

end
