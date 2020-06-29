# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 管理者登録
Admin.create!(
	email: 'admin@aaa.com',
	password: 'administrator'
	)

#ユーザーデータ登録
50.times do |n|
	d_name = Faker::Games::Pokemon.name
	d_email = "example-#{n + 1}@aaa.com"
	d_password ='15711571'
	User.create!(
		name: d_name,
		email: d_email,
		password: d_password,
		password_confirmation: d_password
		)
end

# 依頼ジャンルを登録
RequestGenre.create!([
	{category: 'ホームページ作成'},
	{category: 'ウェブデザイン'},
	{category: 'WordPress制作・導入'},
	{category: 'ライディングページ制作'},
	{category: 'HTML・CSSコーディング'},
	{category: 'SEO対策'},
	{category: 'CMS導入'},
	{category: 'UI設計・UIデザイン'},
	{category: 'スマートフォンサイト制作'},
	{category: 'SNSマーケティング'},
	{category: 'リスティング広告'},
	{category: 'アクセス解析'},
	{category: 'インタラクションデザイン'},
	{category: 'ECサイト制作'},
	{category: 'ECサイトデザイン'}
	])

# スキル項目を登録
Skill.create!([
	{item: 'HTML'},
	{item: 'CSS'},
	{item: 'Ruby'},
	{item: 'Java'},
	{item: 'JavaScript'},
	{item: 'Ruby on Rails'}
	])