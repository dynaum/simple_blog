module Aiur
  class Collection
    include Enumerable

    def initialize(data, page)
      @data, @current_page = data, page
      parse_data
    end

    def each
      @items.each { |item| yield Item.new(item) }
    end

    def total
      @total.to_i
    end

    def per_page
      @per_page.to_i
    end

    def current_page
      @current_page.to_i
    end

    private

    def parse_data
      @items    = @data.split(Aiur::Client::MESSAGE_SEPARATOR)
      @total    = @items.delete_at 0
      @per_page = @items.delete_at 0
    end
  end
end
