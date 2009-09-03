require File.dirname(__FILE__) + '/test_helper.rb'
require File.dirname(__FILE__) + '/../lib/thrift4rails/release_active_record_connection'


# class definition
class TestClass
  include Thrift4Rails::ReleaseActiveRecordConnection

  def self.class_test1
    Array.new
  end

  def self.class_test2(arg)
    Array.new
    arg
  end

  def instance_test1
    Array.new
  end

  def instance_test2(arg)
    Array.new
    arg
  end

end
# end class definition

class TestThrift4Rails < Test::Unit::TestCase
  
  def test_should_code_after_class_method_calls_without_params
    Array.expects(:new).times(2)
    ActiveRecord::Base.expects(:clear_active_connections!)
    assert_equal Array.new ,TestClass.class_test1
  end
  
  def test_should_code_after_class_method_calls_with_params
    Array.expects(:new)
    ActiveRecord::Base.expects(:clear_active_connections!)
    assert_equal "success",TestClass.class_test2("success")
  end
  
  def test_should_code_after_instance_method_calls_without_params
    test_class = TestClass.new
    Array.expects(:new).times(2)
    ActiveRecord::Base.expects(:clear_active_connections!)
    assert_equal Array.new ,test_class.instance_test1
  end
  
  def test_should_code_after_instance_method_calls_with_params
    test_class = TestClass.new
    Array.expects(:new)
    ActiveRecord::Base.expects(:clear_active_connections!)
    assert_equal "success" ,test_class.instance_test2("success")
  end

end