name             'taiga'
maintainer       'John Bellone (<jbellone@bloomberg.net>)'
maintainer_email 'jbellone@bloomberg.net'
license          'Apache 2.0'
description      'Installs/configures Taiga project management platform.'
long_description 'Installs/configures Taiga, open source project management platform.'
version          '0.1.0'

supports 'ubuntu', '~> 12.04'
supports 'ubuntu', '~> 14.04'

%w(centos redhat).each do |name|
  supports name, '~> 6.5'
  supports name, '~> 7.0'
end

depends 'chef-sugar'
depends 'chruby'
depends 'nginx'
depends 'nodejs'
depends 'postgresql'
depends 'python'
depends 'redisio'
