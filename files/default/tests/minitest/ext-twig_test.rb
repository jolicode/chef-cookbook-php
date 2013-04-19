require File.expand_path('../support/helpers', __FILE__)

describe_recipe "jolicode-php::ext-twig" do
  include Helpers::PHPTest

  let(:php_info) { assert_sh("php -i") }

  it "installs the twig extension" do
    php_info.must_include("\ntwig\n")
  end
end