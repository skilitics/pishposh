Gem::Specification.new do |s|
  s.name         = 'powershell'
  s.version      = '0.1.1'
  s.summary      = 'PowerShell wrapper'
  s.description  = 'Wrapper for calling PowerShell scripts'
  s.authors      = ['Jeff Knaggs']
  s.email        = 'jeff.knaggs@skilitix.com'
  s.files        = ['lib/powershell.rb']
  s.homepage     = 'http://github.com/skilitix/powershell'

  s.add_dependency('activesupport', '>= 3.2.12')
end