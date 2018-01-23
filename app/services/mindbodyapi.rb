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

   # The MINDBODY API doesn't accurately filter by StaffID, and StartDateTime, EndDateTime.
   # The response returns all classes on the day before startdatetime and day of startdatetime.
   # at the given location where the staff from staff_id_mb is teaching that day.
   # Need to look further into this. Inconsistent results.

   # filters: hash of class values: staff_id_mb, startdatetime, enddatetime
   # Ex: filters = {
         # 	"filters": {
         # 		"staff_id_mb": "100000164",
         # 		"start_date_time": "2018-01-25T05:00:00.000+00:00",
         # 		"end_date_time": "2018-01-25T06:00:00.000+00:00"
         # 	}
         #}
   def get_staff_classes(filters)
      response = MindBody::Services::ClassService.get_classes('StaffIDs' => {'ids' => filters[:staff_id_mb].to_i }, 'StartDateTime' => filters[:start_date_time].to_datetime, 'EndDateTime' => filters[:end_date_time].to_datetime)
      classes = response.result.first[1]
      staff_classes = {}

      count = 0
      classes.each do |c|
         if c['staff']['id'].to_i == filters[:staff_id_mb].to_i
            if c['start_date_time'].to_date == filters[:start_date_time].to_date
               class_data = {}
               class_data['class_id_mb'] = c['class_schedule_id']
               class_data['staff_name'] = c['staff']['name']
               class_data['staff_id'] = c['staff']['id']
               class_data['class_name'] = c['class_description']['name']
               class_data['start_date_time'] = c['start_date_time']
               class_data['end_date_time'] = c['end_date_time']

               count += 1
               staff_classes[count] = class_data
            end
         end
      end
      staff_classes
   end

end
