package 'socat' do
  action :install
end

execute 'import public key' do
  user 'root'
  command <<-EOH
    rpm --import http://www.rabbitmq.com/rabbitmq-signing-key-public.asc'
    rpm -Uvh http://www.rabbitmq.com/releases/rabbitmq-server/v3.6.4/rabbitmq-server-3.6.4-1.noarch.rpm
  EOH
  not_if 'rpm -qa | grep rabbitmq'
end

service 'rabbitmq-server' do
  action :enable
end
