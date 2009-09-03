# With this Thrif-Client you can easily connect to any thrift service. You just configure the endpoint ans
#
# == Example
#   ThriftClient.new(
#     :url => "http://127.0.0.1:3001/searvice_endpoint",
#     :client_class => Thrift::Definitione::Generated::Client,
#     :cache_methods => { :method_to_be_cached => 1.day }
#   )
# 
# == Throws
# In case of Errno::ECONNREFUSED raises "No connection to Provider: #{@url}. (Original Error: #{e.message})"
# In case of Errno::ETIMEDOUT raises "Connection to Provider '#{@url}' timed out. (Original Error: #{e.message})"
module Thrift4Rails
  class ClientException < Exception; end
  class ThriftClient
    attr_accessor :url, :client_class, :transport, :protocol_factory

    def initialize(options = {})
      @url           = options[:url]
      @client_class  = options[:client_class]
      @cache_methods = options[:cache_methods] || {}
    end
  
    def protocol_factory
      @protocol_factory || Thrift::BinaryProtocolAcceleratedFactory.new
    end

    def protocol_factory=(protocol_factory)
      @protocol_factory = protocol_factory
    end

    def protocol
      @protocol ||= self.protocol_factory.get_protocol(self.transport)
    end

    def client
      @client ||= self.client_class.new(protocol)
    end

    def transport
      @transport ||= Thrift::HTTPClientTransport.new(self.url)
    end

    def method_missing(meth, *args, &blk)
      if client.respond_to?(meth)
        self.class.send :define_method, meth do |*args|
          if @cache_methods[meth] && args.blank?
            Rails.cache.fetch("thrift_client_method_cache_#{meth}", :expire_in => @cache_methods[meth]) do
              fetch_response(meth, *args)
            end
          else
            fetch_response(meth, *args)
          end
        end
        send(meth, *args, &blk)
      else
        super
      end
    end
  
    private

      def fetch_response(meth, *args)
        begin
          transport.open
          response = client.send(meth, *args)
        rescue Thrift::ProtocolException => e
          client_exception = ClientException.new("Either no connection to Provider(#{@url}) or an internal thrift error occured. (Original Error: #{e.message})")
          client_exception.set_backtrace(e.backtrace)
          raise client_exception
        rescue Errno::ECONNREFUSED => e
          client_exception = ClientException.new("No connection to Provider: #{@url}. (Original Error: #{e.message})")
          client_exception.set_backtrace(e.backtrace)
          raise client_exception
        rescue Errno::ETIMEDOUT, Timeout::Error => e
          client_exception = ClientException.new("Connection to Provider '#{@url}' timed out. (Original Error: #{e.message})")
          client_exception.set_backtrace(e.backtrace)
          raise client_exception
        ensure
          transport.close
        end
      end

  end
end