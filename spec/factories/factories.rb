FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "email_#{n}@email.com" }
    password 'password'
    password_confirmation { |u| u.password }
  end

  factory :charity do
    name 'Bob\'s Bait and Tackle for the homeless'
    description { |c| c.name + ' is an awesome place.' }
    website 'http://bobstackle.com'
  end

  factory :invalid_charity, parent: :charity do |f|
    f.name ''
  end

  factory :wallet do
  end

  factory :role do
    name 'admin'
  end
end