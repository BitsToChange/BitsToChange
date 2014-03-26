# Segment.io analytics
Analytics = AnalyticsRuby
Analytics.init({
    secret: ENV["SEGMENTIO_WRITE_KEY"],
    on_error: Proc.new { |status, msg| print msg }
})
