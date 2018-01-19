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

            # Returning nil from test data. Awaiting reply from MINDBODY API team to see if this is returned in actual data.

            # single_staff['email'] = staff['email']
            # single_staff['mobile_phone'] = staff['mobile_phone']
            # single_staff['home_phone'] = staff['home_phone']
            # single_staff['work_phone'] = staff['work_phone']
            # single_staff['login_locations'] = staff['login_locations']
         end
      end
      single_staff
   end

end
