FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}   
    password "foobar"
    password_confirmation "foobar"
  
    factory :admin do
      admin true
    end
  end
  
  factory :firm do
    sequence(:name)  { |n| "Firm #{n}" }
    sequence(:corporate_id) { |n| "1234567-#{n}"}   
    sequence(:location)  { |n| "Location #{n}" }
    sequence(:account_number) { |n| "123123-123#{n}"}
    sequence(:resource)  { |n| Bakery.create(description: "test#{n}") }
  end
  
  factory :material do
    sequence(:name)  { |n| "Material #{n}" }  
  end
  
  factory :recipe do
    sequence(:name)  { |n| "Recipe #{n}" }  
  end
end
