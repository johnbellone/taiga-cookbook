#
# Cookbook: taiga
# License: Apache 2.0
#
# Copyright 2014, 2015, Bloomberg Finance L.P.
#

poise_service_user node['taiga']['service_user'] do
  group node['taiga']['service_group']
end
