# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure('2') do |config|
  config.vm.box      = 'ubuntu/trusty64'
  config.vm.hostname = 'rails-dev-box'

  config.vm.network :forwarded_port, guest: 3000, host: 3000

  config.vm.synced_folder ".", "/home/vagrant/#{dirname = File.basename(Dir.getwd)}", :mount_options => ["dmode=777", "fmode=666"]

  config.vm.provision :shell, path: 'provision-vagrant.sh', keep_color: true
end
