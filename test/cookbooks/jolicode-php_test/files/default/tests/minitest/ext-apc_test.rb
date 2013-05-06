require File.expand_path('../support/helpers', __FILE__)

describe_recipe "jolicode-php_test::ext-apc" do
  include Helpers::CookbookTest

  let(:php_info) { assert_sh("php -i") }

  it "installs the apc extension" do
    php_info.must_include("\napc\n")
  end

  it "sets the right ini values" do
    php_info.must_include("apc.enabled => On => On")
    php_info.must_include("apc.shm_segments => 1 => 1")
    php_info.must_include("apc.shm_size => 64M => 64M")
    php_info.must_include("apc.max_file_size => 10M => 10M")
    php_info.must_include("apc.stat => On => On")
  end
end