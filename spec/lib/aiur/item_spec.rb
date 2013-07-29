require 'spec_helper'

describe Aiur::Item do
  let(:data) do
    { class: 'Article', action: 'create', timestamp: '2013-07-29T02:22:13Z' }
  end

  subject { described_class.new data.to_json  }

  its(:class_name) { should eq 'Article' }
  its(:action)     { should eq 'create' }
  its(:timestamp)  { should be_a Time }
end
