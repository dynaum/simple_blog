require 'spec_helper'

describe ActivitiesController do
  let(:collection) { Aiur::Collection.new '', 1 }

  it "should assign logs" do
    get :index
    assigns(:logs).should be_a Aiur::Collection
  end

  it "should assign paginated_logs" do
    get :index
    assigns(:paginated_logs).should be_a WillPaginate::Collection
  end

  it "should be success" do
    get :index
    response.should be_ok
  end

  context "when there is a page parameter" do
    it "should pass it to Aiur Client" do
      AiurClient.should_receive(:list).with "2"
      get :index, page: 2
    end
  end
end
