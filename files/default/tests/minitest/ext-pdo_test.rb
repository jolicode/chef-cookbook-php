require File.expand_path('../support/helpers', __FILE__)

describe_recipe "jolicode-php::ext-pdo" do
  include Helpers::PHPTest

  let(:php_info) { assert_sh("php -i") }

  it "installs the pdo extension" do
    php_info.must_include("\nPDO\n")
  end
end