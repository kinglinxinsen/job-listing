# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts '欢迎来找！'
puts '這個種子檔會自動建立一個帳號, 並且随机創建 10 個jobs，10个隐藏的jobs'

create_account = User.create([email: 'host@gmail.com', password: '123456', password_confirmation: '123456', is_admin: 'true'])
puts 'Admin account is created successfully!'

job_info = [
  '招聘股票经纪人',
  '招聘操盘手',
  '招聘基金经理',
  '招聘职业培训师',
  '招聘产品经理',
  '招聘前台',
  '招聘市场营销',
  '招聘文员',
  '招聘高级JAVA研发工程师',
  '招聘数据分析工程师',
  '招聘高级客服经理',
  '招聘电脑维修工程师',
  '招聘会计'

]
create_jobs = for i in 1..10 do
                Job.create!([title: job_info[rand(job_info.length)], description: "这是一个公开的工作", wage_upper_bound: rand(40..79) * 1000, wage_lower_bound: rand(20..39) * 1000, is_hidden: 'false'])
              end
for i in 1..10 do
  Job.create!([title: job_info[rand(job_info.length)], description: "这是一个隐藏的工作", wage_upper_bound: rand(40..79) * 1000, wage_lower_bound: rand(20..39) * 1000, is_hidden: 'true'])
end

puts '10 Public jobs created.'
puts '10 Hidden jobs created.'
