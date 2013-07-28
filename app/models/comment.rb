class Comment < ActiveRecord::Base
  include Aiur::Logger
  notify_events

  belongs_to :article

  attr_accessible :body
end
