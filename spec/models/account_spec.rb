RSpec.describe Account, type: :model do
  describe "#name" do
    subject { FactoryGirl.create(:account) }

    it "displays the account name in a human readable format" do
      expect(subject.name).to match(/[a-zA-Z]+\d?[-]\d+/)
    end
  end

  describe "#transaction_changed" do
    it "updates the value of the account" do
      skip
    end
  end

  describe "#to_s" do
    subject { FactoryGirl.create(:account) }
    
    it "is an alias of name" do
      expect(subject.to_s).to eq(subject.name)
    end
  end

end
