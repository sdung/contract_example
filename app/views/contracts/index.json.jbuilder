json.array!(@contracts) do |contract|
  json.extract! contract, :id, :name
  json.url contract_url(contract, format: :json)
end
