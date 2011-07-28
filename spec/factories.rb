Factory.define :user do |user|
  user.name                   "Kim Sergey"
  user.email                  "kiss@faktora.net"
  user.password               "foobar"
  user.password_confirmation  "foobar"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end