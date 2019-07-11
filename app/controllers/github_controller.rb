class GithubController < ApplicationController
  skip_before_action :verify_authenticity_token

  attr_accessor :request_body, :json_body

  class UnsupportedContentTypeError < StandardError; end

  GITHUB_EVENTS = %w(
    issue_comment
    issues
  )
  def payload
    request.body.rewind
    @request_body = request.body.read
    verify_signature
    parse_body
    event = request.headers['X-GitHub-Event']
    if GITHUB_EVENTS.include?(event)
      self.send(event)
    end
  end

  def verify_signature
    signature = 'sha1=' + OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha1'), ENV['SECRET_TOKEN'], request_body)
    return halt 500, "Signatures didn't match!" unless Rack::Utils.secure_compare(signature, request.env['HTTP_X_HUB_SIGNATURE'])
  end

  def parse_body
    @json_body ||= (
      content_type = request.headers['Content-Type']
      case content_type
      when 'application/x-www-form-urlencoded'
        require 'rack'
        payload = Rack::Utils.parse_query(request_body)['payload']
      when 'application/json'
        payload = request_body
      else
        raise UnsupportedContentTypeError.new(
          "Content-Type #{content_type} is not supported. Use 'application/x-www-form-urlencoded' or 'application/json")
      end
      ActiveSupport::HashWithIndifferentAccess.new(JSON.load(payload))
    )
  end

  def issues
    action = json_body[:action]
    events = %w(
      opened
      edited
      labeled
      closed
      reopened
      locked
      unlocked
    )
    issue = Issue.where(number: takeIssueInfo[:number]).first

    if events.include? action
      if issue
        issue.update(takeIssueInfo)
      else
        Issue.create(takeIssueInfo)
      end
    elsif action == 'deleted'
      issue.destroy
    end
  end

  def issue_comment
    action = json_body[:action]
    comment = Comment.where(comment_id: takeCommentInfo[:comment_id]).first

    if action == 'created' || action == 'edited'
      if comment
        comment.update(takeCommentInfo)
      else
        Comment.create(takeCommentInfo)
      end
    elsif action == 'deleted'
      comment.destroy
    end
  end

  private

    def takeIssueInfo
      issue = json_body[:issue]
      return {
        number:           issue[:number],
        title:            issue[:title],
        body:             issue[:body],
        labels:           issue[:labels],
        html_url:         issue[:html_url],
        state:            issue[:state],
        locked:           issue[:locked],
        comments_count:   issue[:comments],
        raw:              @json_body
      }
    end

    def takeCommentInfo
      comment = json_body[:comment]
      issue = json_body[:issue]
      issue = Issue.where(number: issue[:number]).first
      return {
        comment_id:   comment[:id],
        issue_id:     issue.id,
        html_url:     comment[:html_url],
        user:         comment[:user],
        body:         comment[:body]
      }
    end

end
