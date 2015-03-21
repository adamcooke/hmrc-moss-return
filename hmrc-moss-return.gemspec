require File.expand_path('../lib/hmrc_moss/version', __FILE__)

Gem::Specification.new do |s|
  s.name          = "hmrc-moss-return"
  s.description   = %q{A Ruby library for generating a HMRC VAT MOSS return document}
  s.summary       = s.description
  s.homepage      = "https://github.com/adamcooke/hmrc-moss-return"
  s.version       = HMRCMOSS::VERSION
  s.files         = Dir.glob("{lib}/**/*") | ["template.ods"]
  s.require_paths = ["lib"]
  s.authors       = ["Adam Cooke"]
  s.email         = ["me@adamcooke.io"]
  s.licenses      = ['MIT']
  s.add_dependency "rubyzip", "> 1.0", "< 2.0"
end
