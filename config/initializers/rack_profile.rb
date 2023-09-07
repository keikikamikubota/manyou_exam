if defined?(Rack::MiniProfiler)
  Rack::MiniProfiler.config.auto_inject = false
  Rack::MiniProfiler.config.position = 'bottom-right'
end

