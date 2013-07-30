require 'will_paginate/array'

class ActivitiesController < ApplicationController
  def index
    @logs = AiurClient.list(params[:page])
    @paginated_logs = @logs.to_a.paginate page: params[:page], per_page: @logs.per_page, total_entries: @logs.total
  end
end
