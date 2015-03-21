# HMRC VAT MOSS Return Generator (HVMRG)

This library helps you generate a VAT MOSS Return from Ruby. In HMRC's infinate
wisdom, they have decided that users must submit returns in a formatted ODS file.
(unlike the EC Sales List, where they allow you submit CSV).

## Usage

```ruby
require 'hmrc_moss'

# Create a new return and provide the period which you are reporting for.
moss_return = HMRCMOSS::Return.new('Q1/2015')

# Add any sales which you made FROM the UK to other member states.
moss_return.supplies_from_uk do
  line 'AT', :type => 'standard', :rate => 20, :value => 2000, :amount => 10
  line 'DE', :type => 'standard', :rate => 20, :value => 2000, :amount => 10
  line 'FR', :type => 'standard', :rate => 20, :value => 2000, :amount => 10
  line 'NL', :type => 'standard', :rate => 20, :value => 2000, :amount => 10
end

# Add any sales made from fixed establishments in other member states.
moss_return.supplies_from_outside_uk do
  line '123123123', AT', :type => 'standard', :rate => 20, :value => 2000, :amount => 10
  line '123123123', DE', :type => 'standard', :rate => 20, :value => 2000, :amount => 10
  line '123123123', FR', :type => 'standard', :rate => 20, :value => 2000, :amount => 10
  line '123123123', NL', :type => 'standard', :rate => 20, :value => 2000, :amount => 10
end

# Save the restuling file
moss_return.ods_file.save('path/to/return.ods')
```
