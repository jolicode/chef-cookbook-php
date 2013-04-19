require File.expand_path('../support/helpers', __FILE__)

describe_recipe "jolicode-php::ext-mbstring" do
  include Helpers::PHPTest

  let(:php_info) { assert_sh("php -i") }

  it "installs the mbstring extension" do
    php_info.must_include("\nmbstring\n")
  end
end