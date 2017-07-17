# Chef Files/Templates Test and Resource Code

Simplest possible file example on CentOS
```
ChefSpec Test:
  it 'creates a file with the default action' do
      expect(chef_run).to create_file('/tmp/default_action')
  end

Recipe:
  file '/tmp/default_action'
```

