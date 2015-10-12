CronJob = require('cron').CronJob

module.exports = (robot) ->
  # General Cron Tasks
  jobList = [
    { time: '30 10 * * 1-5', msg: '@channel Tea Time!' }
    { time: '00 18 * * 1-5', msg: '@here Hey, turn off air filter, NOW!!!' }
  ]

  jobList.forEach (job) ->
    cronJob = new CronJob job.time, =>
      robot.messageRoom '#general', job.msg
    , null, false, 'Asia/Bangkok'

    cronJob.start()

  # Farang Days
  farangs = ['mac', 'kirati_tripler', 'kantaphon_tripler', 'ekkapob', 'nut']
  farangs.forEach (farang, index) ->
    cronJob = new CronJob "00 11 * * #{index + 1}", =>
      robot.messageRoom '#general', "@channel @#{farang} is Farang! I bet you anything he will not understand Thai anymore!"
    , null, false, 'Asia/Bangkok'

    cronJob.start()
