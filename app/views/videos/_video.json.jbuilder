json.extract! video, :id, :name, :description, :youtube_id, :call_to_action, :resource, :course_id, :created_at, :updated_at
json.url video_url(video, format: :json)
