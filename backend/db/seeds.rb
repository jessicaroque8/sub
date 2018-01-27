# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'random_data'


User.create!(staff_id_mb: 100000285, first_name: 'Ken', last_name: 'Berry', password: 'bananaking', password_confirmation: 'bananaking')
User.create!(staff_id_mb: 100000164, first_name: 'Jennifer', last_name: 'Anderson', password: 'bananaqueen', password_confirmation: 'bananaqueen')
User.create!(staff_id_mb: 100000270, first_name: 'Johnny', last_name: 'Salke', password: 'bananaland', password_confirmation: 'bananaland')
users = User.all

Group.create!(name: 'Yoga')
Group.create!(name: 'Fitness')
Group.create!(name: 'Yoga Assist')
Group.create!(name: 'Fitness Assist')
groups = Group.all

users.each do |user|
   user.groups << groups.sample
end

SubRequest.create!(user: users.sample, group: groups.sample, class_id_mb: 1111, start_date_time: RandomData.datetime(3.days.ago), end_date_time: RandomData.datetime(3.days.ago), class_name: RandomData.word, note: RandomData.sentence)
SubRequest.create!(user: users.sample, group: groups.sample, class_id_mb: 2222, start_date_time: RandomData.datetime(3.days.ago), end_date_time: RandomData.datetime(3.days.ago), class_name: RandomData.word, note: RandomData.sentence)
SubRequest.create!(user: users.sample, group: groups.sample, class_id_mb: 3333, start_date_time: RandomData.datetime(3.days.ago), end_date_time: RandomData.datetime(3.days.ago), class_name: RandomData.word, note: RandomData.sentence)
SubRequest.create!(user: users.sample, group: groups.sample, class_id_mb: 4444, start_date_time: RandomData.datetime(3.days.ago), end_date_time: RandomData.datetime(3.days.ago), class_name: RandomData.word, note: RandomData.sentence)
SubRequest.create!(user: users.sample, group: groups.sample, class_id_mb: 5555, start_date_time: RandomData.datetime(3.days.ago), end_date_time: RandomData.datetime(3.days.ago), class_name: RandomData.word, note: RandomData.sentence)
sub_requests = SubRequest.all

10.times do
   Sendee.create!(user: users.sample, sub_request: sub_requests.sample, sub: false)
end
sendees = Sendee.all

puts "Seeds finished"
puts "#{User.count} users created"
puts "#{Group.count} groups created"
puts "#{SubRequest.count} sub requests created"
puts "#{Sendee.count} sendees created"
