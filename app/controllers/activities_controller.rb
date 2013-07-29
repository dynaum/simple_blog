require 'will_paginate/array'

class ActivitiesController < ApplicationController
  def index
    list = Aiur::Client.new.list(params[:page])
    @logs = list.to_a.paginate page: params[:page], per_page: list.per_page, total_entries: list.total
  end
end
