json.extract! book, :id, :name, :price, :publish, :created_at, :updated_at
json.url book_url(book, format: :json)