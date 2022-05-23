json.extract! pokemon, :id, :name, :order, :base_expirence, :heigth, :weight, :img_url, :created_at, :updated_at
json.url pokemon_url(pokemon, format: :json)
