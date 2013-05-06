require File.expand_path('../support/helpers', __FILE__)

describe_recipe "jolicode-php_test::ext-mysql" do
  include Helpers::CookbookTest

  let(:php_info) { assert_sh("php -i") }

  it "installs the mysql extension" do
    php_info.must_include("\nmysql\n")
  end
end