# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User.delete_all
UserBlockedTime.delete_all


(1..500).each do |index|
  User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name,
              email: Faker::Internet.email, uuid:SecureRandom.urlsafe_base64)
end




def block_user_time(start_time, end_time, number_of_users=10)
  ids = rand_n(number_of_users)
  users = User.where(id: ids)
  users.each do | user |
    blocked_time = "'[#{start_time},#{end_time}]'"
    UserBlockedTime.create(block_type: 'meeting', blocked_time: blocked_time, user: user)
  end
end


def rand_n(n)
  randoms = Set.new
  loop do
    randoms << rand(1..500)
    return randoms.to_a if randoms.size >= n
  end
end

(1..200).each do |index|
  start_hour = rand(7..19)
  start_min = rand(0..50).round(-1) #fix to nearest 10
  end_hour = rand(15..55).round(-1).to_i #fix to nearest 10
  start_time = Time.new(2020,2,28,start_hour,start_min,0, '+05:30')
  end_time = start_time + end_hour.minutes
  total_users = rand(5..10)
  block_user_time(start_time, end_time, total_users)
end



# block_user_time(start_time, end_time)