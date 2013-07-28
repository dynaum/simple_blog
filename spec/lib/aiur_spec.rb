require 'spec_helper'

describe Aiur do
  let(:mock_context) { mock socket: mock_socket }
  let(:mock_socket)  { mock connect: true, send_string: 'send response' }

  class MockLog
    include Aiur
  end

  before do
    ZMQ::Context.stub(:new).and_return mock_context
    mock_socket.stub(:recv_string) { |result| result.replace 'recv response' }
  end

  subject { MockLog.new }

  describe "#add" do
    it "should open ZMQ::REQ socket" do
      mock_context.should_receive(:socket).with ZMQ::REQ
      subject.add "my message"
    end

    it "should send message via zeromq connection" do
      mock_socket.should_receive(:send_string).with("add::my message").ordered
      mock_socket.should_receive(:recv_string).ordered
      subject.add "my message"
    end

    it "should return the call result" do
      subject.add("my message").should eq 'recv response'
    end
  end

  describe "#all" do
    it "should instantiate and return the Aiur::Conllection" do
      subject.all.should be_a Aiur::Collection
    end

    it "pass current page to collection" do
      Aiur::Collection.should_receive(:new).with "recv response", 0
      subject.all
    end

    it "should get collection via zeromq" do
      mock_socket.should_receive(:send_string).with "list::0"
      subject.all
    end

    it "should send the correct page" do
      mock_socket.should_receive(:send_string).with "list::1"
      subject.all 1
    end
  end
end
