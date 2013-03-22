#
# Author::  Joel Wurtz (<jwurtz@jolicode.com>)
# Cookbook Name:: php
#
pkgs = value_for_platform(
  %w(centos redhat scientific fedora) => {
    %w(5.0 5.1 5.2 5.3 5.4 5.5 5.6 5.7 5.8) => %w(php53-pdo),
    'default' => %w(php-pdo)
  },
  [ "debian", "ubuntu" ] => {
    "default" => %w{ }
  },
  "default" => %w{ }
)

pkgs.each do |pkg|
  package pkg do
    action :install
  end
end