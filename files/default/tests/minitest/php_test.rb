require File.expand_path('../support/helpers', __FILE__)

describe_recipe "jolicode-php::php" do
  include Helpers::PHPTest

  let(:php_info) { assert_sh("php -i") }

  it "installs php" do
    assert_sh("php -v").must_include("PHP 5")
  end

  it "sets the right ini values" do
    php_info.must_include("max_execution_time => 0 => 0")
    php_info.must_include("memory_limit => -1 => -1")
    php_info.must_include("display_errors => Off => Off")
    php_info.must_include("html_errors => Off => Off")
  end
end