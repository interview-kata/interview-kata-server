json.extract! comment, :id, :comment_id, :issue_id, :html_url, :issue_url, :user, :body, :created_at, :updated_at
json.url comment_url(comment, format: :json)
