# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'Hello World!'
puts '这个种子档会自动建立一个账号, 并且随机创建 30个公开的jobs，10个隐藏的jobs'

create_account = User.create([email: 'admin@gmail.com', password: '111111', password_confirmation: '111111', is_admin: 'true'])
puts 'Admin account is created successfully!'

job_info1 = [
  '技术总监',
  '项目管理',
  '特效设计师',
  'Web前端开发',
  '游戏原画',
  '游戏界面设计',
  '市场营销',
  'flash设计／开发',
  'python工程师',
  '高级JAVA研发工程师',
  '游戏场景设计',
  '需求分析师'
]
job_info2 = ['广州', '上海', '苏州', '深圳']
job_info3 = ['暴雪', '任天堂', 'uzi', 'Infinity Ward']
create_jobs = for i in 1..30 do
                Job.create!([title: job_info1[rand(job_info1.length)], city: job_info2[rand(job_info2.length)], company: job_info3[rand(job_info3.length)], contact_email:" text@gmail.com", description: "这是一个公开的工作", wage_upper_bound: rand(40..79) * 1000, wage_lower_bound: rand(20..39) * 1000, is_hidden: 'false'])
              end
for i in 1..10 do
  Job.create!([title: job_info1[rand(job_info1.length)], city: job_info2[rand(job_info2.length)], company: job_info3[rand(job_info3.length)], contact_email:" text@gmail.com", description: "这是一个隐藏的工作", wage_upper_bound: rand(40..79) * 1000, wage_lower_bound: rand(20..39) * 1000, is_hidden: 'true'])
end

puts '30 Public jobs created.'
puts '10 Hidden jobs created.'
