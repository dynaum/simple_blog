class Article < ActiveRecord::Base
  include Aiur::Logger
  notify_events

  has_many :comments, dependent: :destroy

  attr_accessible :body, :title
end
