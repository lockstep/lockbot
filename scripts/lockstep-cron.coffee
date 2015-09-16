CronJob = require('cron').CronJob

module.exports = (robot) ->
  jobList = [
    { time: '30 10 * * 1-5', msg: '@channel Tea Time!' }
    { time: '00 17 * * 5', msg: '@channel Beer & Pokdeng Time!' }
  ]

  # for job in jobList
  #   cronJob = new CronJob job.time, =>
  #     robot.messageRoom '#general', job.msg
  #   , null, false, 'Asia/Bangkok'
  #
  #   cronJob.start()

  cronJob = new CronJob '30 10 * * 1-5', =>
    robot.messageRoom '#general', '@channel Tea Time!'
  , null, false, 'Asia/Bangkok'

  cronJob.start()

  cronJob = new CronJob '00 17 * * 5', =>
    robot.messageRoom '#general', '@channel Beer & Pokdeng Time!'
  , null, false, 'Asia/Bangkok'

  cronJob.start()

  cronJob = new CronJob '00 18 * * 1-5', =>
    robot.messageRoom '#general', '@here Hey, turn off air filter, NOW!!!'
  , null, false, 'Asia/Bangkok'

  cronJob.start()
