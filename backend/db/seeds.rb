require 'random_data'


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

# Open
# a = SubRequest.create!(user: johnny, group: yoga, class_id_mb: 5555, start_date_time: DateTime.new(2018, 04, 01, 8, 00, 00), end_date_time: DateTime.new(2018, 04, 01, 9, 00, 00), class_name: RandomData.word, note: RandomData.sentence)
# b = SubRequest.create!(user: jennifer, group: fitness, class_id_mb: 00000, start_date_time: DateTime.new(2018, 04, 9, 10, 00, 00), end_date_time: DateTime.new(2018, 04, 9, 11, 00, 00), class_name: RandomData.word, note: RandomData.sentence)
# c = SubRequest.create!(user: jennifer, group: yoga, class_id_mb: 77777, start_date_time: DateTime.new(2018, 04, 10, 11, 00, 00), end_date_time: DateTime.new(2018, 04, 10, 12, 00, 00), class_name: RandomData.word, note: RandomData.sentence)
#
# sub_requests = SubRequest.all

# Open
# a_sendee = Sendee.create!(user: jennifer, sub_request: a)
# b_sendee = Sendee.create!(user: johnny, sub_request: b)
#
# sendees = Sendee.all




puts "Seeds finished"
puts "#{User.count} users created"
puts "#{Group.count} groups created"
puts "#{SubRequest.count} sub requests created"
puts "#{Sendee.count} sendees created"
