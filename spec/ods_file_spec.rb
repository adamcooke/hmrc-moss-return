require 'tempfile'
require 'hmrc_moss/return'
require 'hmrc_moss/ods_file'

describe HMRCMOSS::ODSFile do
  subject(:moss_return) do
    moss_return = HMRCMOSS::Return.new('Q1/2015')
    moss_return.supplies_from_uk do
      line 'DE', :rate_type => 'potatoland', :rate => 20, :total_sales => 671617, :vat_due => 20
      line 'FR', :rate_type => 'standard', :rate => 25, :total_sales => 1000, :vat_due => 10
    end
    moss_return
  end

  subject do
    HMRCMOSS::ODSFile.new(moss_return)
  end

  it "should have an initial content" do
    expect(subject.content.class).to eq(String)
    expect(subject.content).to include('{{uk:state:1}}')
  end

  it "should have data inserted and no placeholders" do
    subject.add_return_data
    expect(subject.content).to_not include('{{uk:state:')
    expect(subject.content).to_not include('{{f:state:')
    expect(subject.content).to_not include('{{uk:period}}')
    expect(subject.content).to_not include('{{f:period}}')
    expect(subject.content).to include('potatoland')
    expect(subject.content).to include('671617')
  end

  it "should save the completed file to disk" do
    temp_file_path = Tempfile.new('mossreturn').path
    subject.save(temp_file_path)
    expect(subject.content).to include('potatoland')
    expect(File.exist?(temp_file_path)).to eq(true)
    FileUtils.cp(temp_file_path, "/Users/adam/Desktop/test.ods")
  end
end
