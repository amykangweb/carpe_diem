FactoryGirl.define do  factory :tagging do
    tag nil
goal nil
  end
  factory :tag do
    name "MyString"
  end
  factory :friend do
    
  end


  factory :user do
    username "Wilbur"
    email "wilbur@mail.com"
    password "password"
  end
end
