include_recipe 'sensu_common.rb'

template '/etc/sensu/conf.d/client.json' do
  source 'templates/etc/sensu/conf.d/client.json.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

service 'sensu-client' do
  action :enable
end
