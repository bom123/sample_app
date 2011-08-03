namespace :db do
  desc  "Fill database with sample users"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    admin = User.create!(:name => "Test", :email => "test@test.com", :password => "password", :password_confirmation => "password")
    admin.toggle!(:admin)
    99.times do |n|
      name = Faker::Name.name
      email = "test_#{n}@test.com"
      password = "password"
      User.create!(:name => name, :email => email, :password => password, :password_confirmation => password)
    end
    User.all(:limit => 6).each do |user|
      50.times do
        user.microposts.create!(:content => Faker::Lorem.sentence(5))
      end
    end
  end
end