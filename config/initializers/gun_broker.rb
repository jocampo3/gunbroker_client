Rails.application.config.after_initialize do
  GunBroker.dev_key = ENV["GUNBROKER_API_KEY"] if ENV["GUNBROKER_API_KEY"]
  GunBroker.sandbox = ENV.fetch("GUNBROKER_SANDBOX", "false") == "true"
end
