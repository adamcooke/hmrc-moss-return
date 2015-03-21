require 'hmrc_moss/return'

describe HMRCMOSS::Return do

  context "initial state" do
    subject { HMRCMOSS::Return.new('Q1/2015') }
    it "should have a period" do
      expect(subject.period).to eq('Q1/2015')
    end

    it "should have no supplies" do
      expect(subject.supplies_from_uk).to eq([])
      expect(subject.supplies_from_outside_uk).to eq([])
    end
  end

  context "setting UK supplies" do
    subject do
      moss_return = HMRCMOSS::Return.new('Q1/2015')
      moss_return.supplies_from_uk do
        line 'DE', :rate_type => 'standard', :rate => 20, :total_sales => 2000, :vat_due => 20
        line 'FR', :rate_type => 'standard', :rate => 25, :total_sales => 1000, :vat_due => 10
      end
      moss_return
    end

    it "should have have some supplies" do
      expect(subject.supplies_from_uk.size).to eq(2)
    end

    it "should have supplies which are instances of an appropriate class" do
      supply = subject.supplies_from_uk.first
      expect(supply.class).to eq(HMRCMOSS::UKSupply)
      expect(supply.country).to eq('DE')
      expect(supply.rate_type).to eq('standard')
    end
  end

  context "setting non-UK supplies" do
    subject do
      moss_return = HMRCMOSS::Return.new('Q1/2015')
      moss_return.supplies_from_outside_uk do
        line '123 123 123', 'DE', :rate_type => 'standard', :rate => 20, :total_sales => 2000, :vat_due => 20
        line '456 456 456', 'FR', :rate_type => 'standard', :rate => 25, :total_sales => 1000, :vat_due => 10
      end
      moss_return
    end

    it "should have have some supplies" do
      expect(subject.supplies_from_outside_uk.size).to eq(2)
    end

    it "should have supplies which are instances of an appropriate class" do
      supply = subject.supplies_from_outside_uk.first
      expect(supply.class).to eq(HMRCMOSS::NonUKSupply)
      expect(supply.vat_number).to eq('123 123 123')
      expect(supply.country).to eq('DE')
      expect(supply.rate_type).to eq('standard')
    end
  end


end
