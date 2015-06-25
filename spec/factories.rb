FactoryGirl.define do  factory :comment do
    body "MyText"
  end


  factory :user do
    username "Wilbur"
    email "wilbur@mail.com"
    password "password"
  end
end
