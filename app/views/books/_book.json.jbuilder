json.extract! book, :id, :name, :image, :author, :dynasty, :chapter, :section, :content, :commentary, :translation, :appreciation, :interpretation, :background, :created_at, :updated_at
json.url book_url(book, format: :json)