FactoryBot.define do
  factory :user do
     response = MindBody::Services::StaffService.get_staff('StaffCredentials' => {'Username' => username, 'Password' => password, 'SiteIDs' => siteIDs } )
     result = response.result
     id = result[:staff_members][:id]

    staff_id_MB { id }
  end
end
