FactoryGirl.define do
  factory :account do
    number { 1 }
    association :prefix, factory: :account_prefix
    value { 1.0 }
  end

end
