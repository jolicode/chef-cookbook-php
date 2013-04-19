require File.expand_path('../support/helpers', __FILE__)

describe_recipe "jolicode-php::ext-mysql" do
  include Helpers::PHPTest

  let(:php_info) { assert_sh("php -i") }

  it "installs the mysql extension" do
    php_info.must_include("\nmysql\n")
  end
end