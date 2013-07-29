class Aiur::Item
  def initialize(data)
    @data = JSON.parse data
  end

  def class_name
    @data['class']
  end

  def action
    @data['action']
  end

  def timestamp
    Time.parse @data['timestamp']
  end
end
