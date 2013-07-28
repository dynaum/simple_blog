require 'spec_helper'

describe Aiur::Collection do
  subject { described_class.new "100::20::item 1::item 2", 0 }

  its(:total)        { should eq 100 }
  its(:per_page)     { should eq 20 }
  its(:current_page) { should eq 0 }

  it "should parse elements" do
    subject.to_a.should eq ["item 1", "item 2"]
  end
end
