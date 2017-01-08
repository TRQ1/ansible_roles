require 'spec_helper'

# Check docker-swarm that be provided by Vagrant and ansbile

describe selinux do
  it { should be_disabled }
end

describe group('root') do
  it { should have_gid 0 }
end

['wheel','vagrant','docker'].echo do|groups|
describe group(groups) do
  it { should exist }
end

describe file('/etc/shadow') do
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 000 }
end


#check installed package
['docker-engine','docker-py','ansible'].each do |Package|
describe 'check installed package' do
  describe package(Package) do
    it { should be_installed }
  end
end
