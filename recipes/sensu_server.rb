package 'epel-release' do
  action :install
end

include_recipe 'rabbitmq.rb'
include_recipe 'redis.rb'

execute 'Add vhost' do
  user 'root'
  command <<-EOH
    sudo rabbitmqctl add_vhost /sensu
    sudo rabbitmqctl add_user sensu secret
    sudo rabbitmqctl set_permissions -p /sensu sensu ".*" ".*" ".*"
  EOH
  not_if 'rabbitmqctl list_vhosts | grep sensu'
end

include_recipe 'sensu_common.rb'

package 'uchiwa' do
  action :install
end

template '/etc/sensu/uchiwa.json' do
  source 'templates/etc/sensu/uchiwa.json.erb'
  owner 'uchiwa'
  group 'sensu'
  mode '0600'
end

%w[
  sensu-server
  sensu-client
  sensu-api
  uchiwa
].each do |svc|
  service svc do
    action :enable
  end
end
