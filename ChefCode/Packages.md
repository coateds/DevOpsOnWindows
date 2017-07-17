# Chef Packages Test and Resource Code

Simple package example on CentOS
```
ChefSpec Test:
  require 'spec_helper'

  describe 'lcd_web::default' do
    context 'CentOS' do
      let(:chef_run) do
        runner = ChefSpec::ServerRunner.new(platform: 'centos', version: '7.2.1511')
        runner.converge(described_recipe)
      end

      it 'converges successfully' do
        expect { chef_run }.to_not raise_error
      end

      it 'installs httpd' do
        expect(chef_run).to install_package('httpd')
      end

      it 'installs net-tools' do
        expect(chef_run).to install_package('net-tools')
      end

      it 'enables the httpd service' do
        expect(chef_run).to enable_service('httpd')
      end

      it 'starts the httpd service' do
        expect(chef_run).to start_service('httpd')
      end

    end
  end


InSpec Test:
  ['net-tools', 'httpd'].each do |pkg|
    describe package(pkg) do
      it { should be_installed }
    end
  end

Recipe:

package 'httpd'
package 'net-tools'

service 'httpd' do
service platform_service_httpd do
  action [:enable, :start]
end

```