$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'activesupport'
require 'thrift4rails/thrift_client'

module Thrift4Rails
  VERSION = '0.0.3'
end