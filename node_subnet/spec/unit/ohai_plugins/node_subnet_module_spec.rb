require 'spec_helper'

describe_ohai_plugin :Apache do
  let(:plugin_file) { 'files/default/node_subnet_module.rb' }

  it 'provides apache/modules' do
    expect(plugin).to provides_attribute('"hostname", "ENV"')
  end

  let(:command) { double('Fake Command',stdout: 'OUTPUT') }

  it 'correctly captures output' do
    allow(plugin).to receive(:shell_out).with('ip -o -f inet addr show | awk '/scope global/ {print $4}'').and_return(command)
    expect(plugin_attribute('"hostname", "ENV"')).to eq('OUTPUT')
  end
end