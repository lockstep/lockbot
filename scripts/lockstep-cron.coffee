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

  cronJob = new CronJob '00 18 * * 1-5', =>
    robot.messageRoom '#general', '@here Hey, turn off air filter, NOW!!!'
  , null, false, 'Asia/Bangkok'

  cronJob.start()

  cronJob = new CronJob '00 11 * * 1', =>
    robot.messageRoom '#general', '@channel @mac is Farang! I bet you anything he will not understand Thai anymore!'
  , null, false, 'Asia/Bangkok'

  cronJob.start()

  cronJob = new CronJob '00 11 * * 2', =>
    robot.messageRoom '#general', '@channel @kirati_tripler is Farang! I bet you anything he will not understand Thai anymore!'
  , null, false, 'Asia/Bangkok'

  cronJob.start()

  cronJob = new CronJob '00 11 * * 3', =>
    robot.messageRoom '#general', '@channel @kantaphon_tripler is Farang! I bet you anything he will not understand Thai anymore!'
  , null, false, 'Asia/Bangkok'

  cronJob.start()

  cronJob = new CronJob '00 11 * * 4', =>
    robot.messageRoom '#general', '@channel @ekkapob is Farang! I bet you anything he will not understand Thai anymore!'
  , null, false, 'Asia/Bangkok'

  cronJob.start()

  cronJob = new CronJob '00 11 * * 5', =>
    robot.messageRoom '#general', '@channel @nut is Farang! I bet you anything he will not understand Thai anymore!'
  , null, false, 'Asia/Bangkok'

  cronJob.start()
