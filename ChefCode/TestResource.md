# Chef Testing and Resource Code
This page and its children are for studying and then example references for unit and integration testing syntax and then the resource code. For each topic or group of topics, examples will be provided for ChefSpec and InSpec code as well as resource code.

## File Structure for Tests and Resources
Note that there are two sets here, default and users
```
Resources go in recipes
├── recipes
│   ├── default.rb
│   └── users.rb

ChefSpec/RSpec unit tests go here:
├── spec
│   ├── spec_helper.rb
│   └── unit
│       └── recipes
│           ├── default_spec.rb
│           └── users_spec.rb

InSpec integration tests go here:
└── test
    └── smoke
        └── default
            ├── default_test.rb
            └── users_test.rb
```

## ChefSpec prerequisites
spec_helper.rb file needs configuring. For the LinuxAcademy course, the following was put into the generator:
```
# frozen_string_literal: true
require 'chefspec'
require 'chefspec/berkshelf'

RSpec.configure do |config|
  config.platform = 'centos'
  config.version = '7.2.1511'
end
```
default_spec.rb also needs some modifying. The LinuxAcademy example:
```
#
# Cookbook:: lcd_web
# Spec:: default
#
# Copyright:: 2017, Dave, All Rights Reserved.

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

    it 'some test' do
      expect(chef_run)  blah, blah...
    end

  end
end

```

## ChefSpec Examples and resources.
There seem to be a huge number of ChefSpec examples <a href="https://github.com/chefspec/chefspec/tree/master/examples">here</a>:

`chef exec rspec` to run tests

Note: ChefSpec "runs" out of the box on a Windows cookbook even though it seems to be customized for Ubuntu.

https://chefspec.github.io/chefspec/

For Windows:
ChefSpec::ServerRunner.new(platform: 'windows', version: '2012R2')

spec_helper.rb:
```
RSpec.configure do |config|
  config.platform = 'windows'
  config.version = '2012R2'
end
```