RSpec.describe Account::Prefix, type: :model do
  it { should have_many :accounts }
  it { should validate_presence_of :name }

  describe "#name" do
    subject { FactoryGirl.create(:account_prefix) }

    it "displays the prefix in a human readable format" do
      expect(subject.name).to be_a(String)
      expect(subject.name).to match(/[A-Z]+[0-9]?/)
    end
  end

  describe "#to_s" do
    subject { FactoryGirl.create(:account_prefix) }
    
    it "is an alias of name" do
      expect(subject.to_s).to eq(subject.name)
    end
  end
end
