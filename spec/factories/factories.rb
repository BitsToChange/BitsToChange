FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "email_#{n}@email.com" }
    password 'password'
    password_confirmation { |u| u.password }
  end

  factory :charity_administrator, parent: :user do |f|
    f.roles { [create(:role, name: Constants::Roles::CHARITY_ADMINISTRATOR)] }
  end

  factory :charity do
    name 'Bob\'s Bait and Tackle for the homeless'
    description { |c| c.name + ' is an awesome place.' }
    website 'http://bobstackle.com'
  end

  factory :invalid_charity, parent: :charity do |f|
    f.name ''
  end

  factory :campaign do
    name 'Bob\'s Run for Cancer'
    description { |c| c.name + ' is a great cause.' }
    goal 50000
  end

  factory :invalid_campaign, parent: :campaign do |f|
    f.name ''
  end

  factory :wallet do
  end

  factory :role do
    name 'admin'
  end
end