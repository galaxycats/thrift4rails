module Thrift4Rails
  class ClientStubForTesting
    def method_missing(meth, *args, &blk)
      return true
    end
  end
end