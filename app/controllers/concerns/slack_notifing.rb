module SlackNotifing
  extend ActiveSupport::Concern

  def slack(object)
    return if ApplicationController::skip_slack
    notifier = Slack::Notifier.new "https://hooks.slack.com/services/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", username: 'parti-gonu'
    message = make_message(object)
    if message.present?
      notifier.ping("", attachments: [{ text: message, color: "#36a64f" }])
    end
  end

  private

  def make_message(object)
    case "#{controller_name}##{action_name}"
    when "comments#create"
      stand = object.stand
      poster = stand.poster

      return <<EOF
대자보 #{poster.url} \"#{poster.question}\"
#{stand.user.email}의 입장에 대해 #{object.user.email}이 댓글을 남겼습니다.
#{object.body} >>> [보기](#{stand_url stand})
EOF
    when "posters#create"
      return <<EOF
대자보 #{object.url} \"#{object.question}\"
#{object.user.email}이 새로운 대자보를 붙였습니다. >>> [보기](#{poster_url object})
EOF
    when "stands#create"
      poster = object.poster
      return <<EOF
대자보 #{poster.url} \"#{poster.question}\"
#{object.user.email}이 입장을 밝혔습니다. >>> [보기](#{stand_url object})
EOF
    when "stands#update"
      poster = object.poster
      return <<EOF
대자보 #{poster.url} \"#{poster.question}\"
#{object.user.email}이 입장을 고쳤습니다. >>> [보기](#{stand_url object})
EOF
    when "supports#create"
      poster = object.target.poster
      return <<EOF
대자보 #{poster.url} \"#{poster.question}\"
#{object.stand.user.email}이 #{object.target.user.email}입장을 지지합니다. >>> [보기](#{stand_url object.target})
EOF
    when "supports#destroy"
      poster = object.target.poster
      return <<EOF
대자보 #{poster.url} \"#{poster.question}\"
#{object.stand.user.email}이 #{object.target.user.email}입장에 대해 지지철회합니다. >>> [보기](#{stand_url object.target})
EOF
    else
      nil
    end
  end

end
