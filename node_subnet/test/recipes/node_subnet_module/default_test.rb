plugin_directory = '/tmp/kitchen/ohai/plugins'

describe command("ohai -d #{plugin_directory} Hostname") do
  its(:stdout) { should match(/core_module/) }
end