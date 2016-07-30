remote_file '/etc/yum.repos.d/sensu.repo' do
  source 'remote_files/etc/yum.repos.d/sensu.repo'
  owner 'root'
  group 'root'
end

package 'sensu' do
  action :install
end

template '/etc/sensu/config.json' do
  source 'templates/etc/sensu/config.json.erb'
  owner 'root'
  group 'root'
  mode '0644'
end
