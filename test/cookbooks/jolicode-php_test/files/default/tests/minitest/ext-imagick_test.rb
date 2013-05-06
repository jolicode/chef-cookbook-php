require File.expand_path('../support/helpers', __FILE__)

describe_recipe "jolicode-php_test::ext-imagick" do
  include Helpers::CookbookTest

  let(:php_info) { assert_sh("php -i") }

  it "installs the imagick extension" do
    php_info.must_include("\nimagick\n")
  end
end