FactoryGirl.define do
  factory :account_prefix, :class => 'Account::Prefix' do
    name { FFaker::NatoAlphabet.alphabetic_code }
  end

end
