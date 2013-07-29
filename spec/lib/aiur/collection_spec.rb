require 'spec_helper'

describe Aiur::Collection do
  subject { described_class.new "100::20::{\"these\":\"data\"}::{\"these\":\"data\"}", 0 }

  its(:total)        { should eq 100 }
  its(:per_page)     { should eq 20 }
  its(:current_page) { should eq 0 }

  it "should parse elements as Aiur Item" do
    subject.to_a.first.should be_a Aiur::Item
  end
end
