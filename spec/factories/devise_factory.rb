FactoryBot.define do 
  factory :user do 
    id {1}
    email {"example@wizeline.com"}
    password {"1234567"}
    login_name {"example1"}
  end
end