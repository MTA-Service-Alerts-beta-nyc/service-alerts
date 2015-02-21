json.array!(@alerts) do |alert|
  json.extract! alert, :id
  json.url alert_url(alert, format: :json)
end
