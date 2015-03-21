require 'hmrc_moss/supply'

describe HMRCMOSS::Supply do

  context "valid supply" do
    subject do
      HMRCMOSS::Supply.new(:country => 'FR', :rate_type => 'standard', :rate => 20, :total_sales => 20, :vat_due => 2)
    end

    it "should be valid" do
      expect(subject.valid?).to eq(true)
    end

    it "should have accessors for attributes" do
      expect(subject.country).to eq('FR')
      expect(subject.rate_type).to eq('standard')
      expect(subject.rate).to eq(20)
      expect(subject.total_sales).to eq(20)
      expect(subject.vat_due).to eq(2)
    end
  end

  context "invalid supply" do
    subject do
      HMRCMOSS::Supply.new(:country => 'FR')
    end

    it "should not be valid" do
      expect(subject.valid?).to eq(false)
    end
  end

end
