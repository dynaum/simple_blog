module Aiur
  class Client
    MESSAGE_SEPARATOR = "::"

    def initialize
      connect
    end

    def add(message)
      request { make_message(:add, message) }
    end

    def list(page = nil)
      page ||= 1
      Collection.new(request { make_message(:list, page.to_i - 1) }, page)
    end

    private

    def request
      socket.send_string yield
      "".tap { |result| socket.recv_string result }
    end

    def make_message(action, message)
      [action, message].join MESSAGE_SEPARATOR
    end

    def context
      @context ||= ZMQ::Context.new
    end

    def socket
      @socket ||= context.socket ZMQ::REQ
    end

    def connect
      socket.connect config
    end

    def config
      ::AppConfig.zeromq_uri
    end
  end
end
