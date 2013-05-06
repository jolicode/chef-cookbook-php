require File.expand_path('../support/helpers', __FILE__)

describe_recipe "jolicode-php_test::ext-pgsql" do
  include Helpers::CookbookTest

  let(:php_info) { assert_sh("php -i") }

  it "installs the pgsql extension" do
    php_info.must_include("\npgsql\n")
  end
end