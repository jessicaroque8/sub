require 'random_data'


ken = User.create!(staff_id_mb: 100000285, first_name: 'Ken', last_name: 'Berry', email: 'ken@email.com', password: 'hanuman8', image: 'https://thumb.ibb.co/i0aF66/image_1.png')
jennifer = User.create!(staff_id_mb: 100000164, first_name: 'Jennifer', last_name: 'Anderson', email: 'jennifer@email.com', password: 'saraswati8', image: 'https://image.ibb.co/cMrBeR/image_2.png')
johnny = User.create!(staff_id_mb: 100000270, first_name: 'Johnny', last_name: 'Salke', email: 'johnny@email.com', password: 'prajaprati', image: 'https://thumb.ibb.co/nGmcKR/image_3.png')

users = User.all

yoga = Group.create!(name: 'Yoga')
fitness = Group.create!(name: 'Fitness')
yoga_assist = Group.create!(name: 'Yoga Assist')
fitness_assist = Group.create!(name: 'Fitness Assist')
groups = Group.all

users.each do |user|
   user.groups << groups.sample
end

# Open
a = SubRequest.create!(user: johnny, group: yoga, class_id_mb: 5555, start_date_time: DateTime.new(2018, 04, 01, 8, 00, 00), end_date_time: DateTime.new(2018, 04, 01, 9, 00, 00), class_name: RandomData.word, note: RandomData.sentence)
b = SubRequest.create!(user: jennifer, group: fitness, class_id_mb: 00000, start_date_time: DateTime.new(2018, 04, 9, 10, 00, 00), end_date_time: DateTime.new(2018, 04, 9, 11, 00, 00), class_name: RandomData.word, note: RandomData.sentence)
c = SubRequest.create!(user: jennifer, group: yoga, class_id_mb: 77777, start_date_time: DateTime.new(2018, 04, 10, 11, 00, 00), end_date_time: DateTime.new(2018, 04, 10, 12, 00, 00), class_name: RandomData.word, note: RandomData.sentence)

# Closed
d = SubRequest.create!(user: jennifer, group: fitness, class_id_mb: 11111, start_date_time: DateTime.new(2018, 05, 10, 8, 00, 00), end_date_time: DateTime.new(2018, 05, 10, 9, 00, 00), class_name: RandomData.word, note: RandomData.sentence)
e = SubRequest.create!(user: jennifer, group: yoga, class_id_mb: 22222, start_date_time: DateTime.new(2018, 05, 10, 13, 00, 00), end_date_time: DateTime.new(2018, 05, 10, 14, 00, 00), class_name: RandomData.word, note: RandomData.sentence)
f = SubRequest.create!(user: johnny, group: fitness_assist, class_id_mb: 55552, start_date_time: DateTime.new(2018, 05, 01, 18, 00, 00), end_date_time: DateTime.new(2018, 05, 01, 19, 00, 00), class_name: RandomData.word, note: RandomData.sentence)


sub_requests = SubRequest.all

# Open
a_sendee = Sendee.create!(user: jennifer, sub_request: a)
b_sendee = Sendee.create!(user: johnny, sub_request: b)

# Closed
d_sendee = Sendee.create!(user: johnny, sub_request: e)
f_sendee = Sendee.create!(user: jennifer, sub_request: f)

sendees = Sendee.all




puts "Seeds finished"
puts "#{User.count} users created"
puts "#{Group.count} groups created"
puts "#{SubRequest.count} sub requests created"
puts "#{Sendee.count} sendees created"
