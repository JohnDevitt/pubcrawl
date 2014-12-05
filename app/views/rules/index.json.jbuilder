json.array!(@rules) do |rule|
  json.extract! rule, :id, :title, :details
  json.url rule_url(rule, format: :json)
end
