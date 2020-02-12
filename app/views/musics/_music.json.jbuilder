json.extract! music, :id, :name, :audio_url, :artists, :album_url, :lyric, :created_at, :updated_at
json.url music_url(music, format: :json)
