include_recipe 'selinux::disabled'

%w(vim-enhanced wget git).each do |pkg|
  package pkg do
    action :install
  end
end
