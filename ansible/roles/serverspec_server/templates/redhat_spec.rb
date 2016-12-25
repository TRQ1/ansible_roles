require 'spec_helper'

# Check default system setting

describe selinux do
  it { should be_disabled }
end

describe group('root') do
  it { should have_gid 0 }
end

describe group('wheel') do
  it { should exist }
end

describe file('/etc/shadow') do
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 000 }
end

# Check Linux kernel parameter
describe 'Linux kernel parameters' do
  context linux_kernel_parameter('net.ipv4.tcp_syncookies') do 
    its(:value) { should eq 1 }
  end

  context linux_kernel_parameter('kernel.shmall') do
    its(:value) { should be >= 4294967296 }
  end

  context linux_kernel_parameter('kernel.shmmax') do
    its(:value) { should be <= 68719476736 }
  end
end

# Check allowed service in version 7
[ 'crond','dbus','irqbalance','libvirtd','lvm2-lvmetad','lvm2-monitor','network','rsyslog','sshd','sysstat','tuned','vsftpd','xinetd' ].each do |services|
  describe service(services) do
   it { should be_enabled.with_level(3) }
   it { should be_running }
  end

end

#check installed package
describe 'check installed package' do
  describe package('ntpd') do
    it { should be_installed }
  end
  
  describe package('telnet') do
    it { should be_installed }
  end
end
