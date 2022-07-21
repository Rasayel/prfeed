class Team < ApplicationRecord

  has_many :blurbs, class_name: "PullRequestBlurb"

  before_save :validate_slack_channel!

  def validate_slack_channel!
    client = Slack::Web::Client.new
    response = client.chat_postMessage(
      channel: slack_channel,
      text: "Team `#{name}` being added to pr feed"
    )
    reaction_response = client.reactions_add(name: "white_check_mark", channel: slack_channel, timestamp: response["ts"])
    raise ArgumentError "Slack channel id is not correct" unless reaction_response["ok"] == true
  end

end
