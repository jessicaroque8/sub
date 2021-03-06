require 'random_data'

# The following seed info reflects the test data from my personal MINDBODY Sandbox.
# You may need to modify the seed users for your own Sandbox:
# 1. Identify staff names in the Class Schedule on the MINDBODY Sandbox
# 2. Open the Rails console:
#      $ rails c
#      $ require 'MindBodyAPI'
#      $ mb = MindBodyAPI.new
#      $ mb.get_single_staff('any_username', 'any_password', staff1_first_name, staff1_last_name)
#      $ mb.get_single_staff('any_username', 'any_password', staff2_first_name, staff2_last_name)
# 3. Modify the user seeds below to create an account for each staff member using the outputted data as the user attributes,
#    (staff_id_mb: id, first_name: first_name, last_name: last_name, image: image) and any values for email and password.

jennifer = User.create!(staff_id_mb: 100000164, first_name: 'Jennifer', last_name: 'Anderson', email: 'jennifer@email.com', password: 'saraswati8', image: 'https://image.ibb.co/cMrBeR/image_2.png')
johnny = User.create!(staff_id_mb: 100000270, first_name: 'Johnny', last_name: 'Salke', email: 'johnny@email.com', password: 'prajaprati', image: 'https://thumb.ibb.co/nGmcKR/image_3.png')

users = User.all

yoga = Group.create!(name: 'Yoga')
fitness = Group.create!(name: 'Fitness')
groups = Group.all

users.each do |user|
   groups.each do |group|
      user.groups << group
   end
end


puts "Seeds finished"
puts "#{User.count} users created"
puts "#{Group.count} groups created"
