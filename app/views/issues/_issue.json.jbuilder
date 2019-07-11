json.extract! issue, :id, :number, :title, :body, :labels, :html_url, :state, :locked, :comments_count, :raw, :created_at, :updated_at
json.url issue_url(issue, format: :json)
