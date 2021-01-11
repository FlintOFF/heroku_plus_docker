json.extract! note, :id, :header, :body, :created_at, :updated_at
json.url note_url(note, format: :json)
