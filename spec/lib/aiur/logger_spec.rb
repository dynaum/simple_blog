require 'spec_helper'

describe Aiur::Logger do
  let(:article) { Article.create title: 'My title', body: 'My body' }

  before do
    Timecop.freeze Time.local(2013, 1, 21, 10, 0, 0)
  end

  class FakeModel
    include ActiveSupport::Callbacks
    include Aiur::Logger

    define_callbacks :create
    define_callbacks :update
    define_callbacks :destroy

    notify_events

    def updated_at
      Time.now
    end
  end

  subject { FakeModel.new }

  after { Timecop.return }

  it "should call Aiur to store the message" do
    AiurClient.should_receive(:add).with('{"class":"FakeModel","action":"create","timestamp":"2013-01-21T10:00:00-02:00"}')
    subject.run_callbacks :create
  end

  it "should bind create" do
    subject.should_receive(:send_message).with :create
    subject.run_callbacks :create
  end

  it "should bind update" do
    subject.should_receive(:send_message).with :update
    subject.run_callbacks :update
  end

  it "should bind destroy" do
    subject.should_receive(:send_message).with :destroy
    subject.run_callbacks :destroy
  end
end
