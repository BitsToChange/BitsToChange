class MockAnalytics
  attr_accessor :identifications

  def initialize
    self.identifications = []
  end

  def identify(options = {})
    self.identifications << options
  end
end

Before do
  @unmocked_analytics = Analytics
  silence_warnings do
    Analytics = MockAnalytics.new
  end
end

After do
  silence_warnings do
    Analytics = @unmocked_analytics
  end
end