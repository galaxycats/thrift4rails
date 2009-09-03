$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'activesupport'
require "activerecord"
require 'thrift4rails/thrift_client'
require 'thrift4rails/client_stub_for_testing'
require 'thrift4rails/release_active_record_connection'

module Thrift4Rails
  VERSION = '0.3.1'
end