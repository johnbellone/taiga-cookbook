#
# Cookbook Name:: taiga
# Attribute:: default
# License:: Apache 2.0 (see http://www.apache.org/licenses/LICENSE-2.0)
#
default['taiga']['user'] = 'taiga'
default['taiga']['group'] = 'taiga'

default['taiga']['front']['git_url'] = 'https://github.com/taigaio/taiga-front'
default['taiga']['front']['git_ref'] = 'master'

default['taiga']['back']['git_url'] = 'https://github.com/taigaio/taiga-back'
default['taiga']['back']['git_ref'] = 'master'
