url           = require('url')
querystring   = require('querystring')
_             = require('lodash')

module.exports = (robot) ->
  pullRequests = []
  reviewers = [
    { ghName: 'roonglit', slackName: 'mac' },
    { ghName: 'gotzilaza', slackName: 'kirati_tripler' },
    { ghName: 'gunosk129', slackName: 'kantaphon_tripler' },
    { ghName: 'janklimo', slackName: 'jan' },
    { ghName: 'n-thongjor', slackName: 'nut' },
    { ghName: 'ekkapob', slackName: 'ekkapob' }
  ]

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
    pr = data.pull_request
    id = pr.title.match(/\[(.*)\]/i)?[1]
    if id
      owner = pr.user.login
      commentEndpoint = pr._links.comments.href
      relatedPr = _.find pullRequests, (pr) -> pr.id is id

      if relatedPr
        reviewer = relatedPr.reviewer
        ghMessage = JSON.stringify(body: "@#{reviewer.ghName} Please continue to review!. Type :+1: when you've done.")
        skMessage = "@#{reviewer.slackName}, please continue to review #{pr.html_url}"
      else
        reviewer = reviewers.shift()
        ghMessage = JSON.stringify(body: "@#{reviewer.ghName} You are the first reviewer!, please review. Type :+1: when you've done.")
        skMessage = "Congrats! @#{reviewer.slackName}, you are the first reviewer of #{pr.html_url}"
        pullRequests.push
          id: id
          owner: owner
          reviewer: reviewer
        reviewers.push(reviewer)

      robot.http(commentEndpoint)
           .header('Authorization', "token #{process.env.HUBOT_GITHUB_ACCESS_TOKEN}")
           .post(ghMessage) (err, res, body) ->
             robot.messageRoom '#lootix', skMessage
    else
      robot.messageRoom '#lootix', "PR with `#{pr.title}` does not match. Please use [.\*] .\* for PR title, ex: [LT-101] Add awesome bot."
