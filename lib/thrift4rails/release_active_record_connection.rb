module Thrift4Rails
  module ReleaseActiveRecordConnection
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def singleton_method_added(method_name) 
        @@class_singleton_methods  ||= []
        if !(method_name.to_s =~ /_execution_callback/) && !@@class_singleton_methods.include?(method_name)
          @@class_singleton_methods << method_name
          @@current_method_name = method_name
          class << self
            method_name = @@current_method_name
            define_method "#{method_name}_with_execution_callback" do |*args|
              return_value = self.send("#{method_name}_without_execution_callback", *args)
              ActiveRecord::Base.clear_active_connections!
              return return_value
            end
            alias_method_chain method_name, :execution_callback
          end
        end
      end
      
      def method_added(method_name)
        @@class_instance_methods ||= []
        if !(method_name.to_s =~ /_execution_callback/) && !@@class_instance_methods.include?(method_name)
          @@class_instance_methods << method_name
          define_method "#{method_name}_with_execution_callback" do |*args|
            return_value = self.send("#{method_name}_without_execution_callback", *args)
            ActiveRecord::Base.clear_active_connections!
            return return_value
          end
          alias_method_chain method_name, :execution_callback
        end
      end
    end

  end
end