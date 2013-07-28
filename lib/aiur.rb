require 'aiur/collection'

module Aiur
  MESSAGE_SEPARATOR = "::"

  def add(message)
    request { make_message(:add, message) }
  end

  def all(page = 0)
    Collection.new(request { make_message(:list, page) }, page)
  end

  private

  def request
    connect
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
