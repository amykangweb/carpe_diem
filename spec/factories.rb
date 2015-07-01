FactoryGirl.define do
  factory :user do
    username "Wilbur"
    email "wilbur@mail.com"
    password "password"
  end

  factory :friend, class: User do
    username "Amy"
    email "amy@mail.com"
    password "password"
  end

  factory :admin, class: User do
    username "Admin"
    email "admin@mail.com"
    password "password"
    admin true
  end
end
