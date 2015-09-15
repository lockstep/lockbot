url           = require('url')
querystring   = require('querystring')

module.exports = (robot) ->
  robot.router.post "/hubot/gh-repo-events", (req, res) ->
    query = querystring.parse(url.parse(req.url).query)
    data = req.body
    eventType = req.headers["x-github-event"]

    switch eventType
      when 'pull_request' then _handlePullRequestEvent(data)

    res.end ''

  _handlePullRequestEvent = (data) ->
    switch data.action
      when 'opened' then _assignFirstReviewer(data)

  _assignFirstReviewer = (data) ->
    reviewers = [
      { ghName: 'ekkapob', slackName: 'ekkapob' },
      { ghName: 'gotzilaza', slackName: 'kirati_tripler' },
      { ghName: 'gunosk129', slackName: 'kantaphon_tripler' },
      { ghName: 'janklimo', slackName: 'jan' },
      { ghName: 'n-thongjor', slackName: 'nut' },
      { ghName: 'roonglit', slackName: 'mac' }
    ]

    reviewer = reviewers[Math.floor(Math.random() * reviewers.length)]
    commentEndpoint = data.pull_request._links.comments.href
    message = JSON.stringify(body: "@#{reviewer.ghName} You are the first reviewer!, please review. Type :+1: when you've done.")

    robot.http(commentEndpoint)
         .header('Authorization', "token #{process.env.HUBOT_GITHUB_ACCESS_TOKEN}")
         .post(message) (err, res, body) ->
           robot.messageRoom '#lootix', "Congrats! @#{reviewer.slackName}, you are the first reviewer of #{data.pull_request.html_url}"
