FactoryGirl.define do
  factory :user do
    username "Wilbur"
    email "wilbur@mail.com"
    password "password"
    confirmed_at Time.now
  end

  factory :friend, class: User do
    username "Amy"
    email "amy@mail.com"
    password "password"
    confirmed_at Time.now
  end

  factory :admin, class: User do
    username "Admin"
    email "admin@mail.com"
    password "password"
    admin true
    confirmed_at Time.now
  end
end
