require 'spec_helper'

describe ActivitiesController do
  it "should assign logs as WillPaginate::Collection" do
    get :index
    assigns(:logs).should be_a WillPaginate::Collection
  end

  it "should be success" do
    get :index
    response.should be_ok
  end

  context "when there is a page parameter" do
    let(:list_mock)   { Aiur::Collection.new "", 0 }
    let(:client_mock) { mock list: list_mock }

    it "should pass it to Aiur Client" do
      Aiur::Client.stub(:new).and_return client_mock
      client_mock.should_receive(:list).with "2"

      get :index, page: 2
    end
  end
end
