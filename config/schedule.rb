# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#

every 5.minutes, roles: [:app] do
  runner "TwitterUsernameJob.runner"
end

# Learn more: http://github.com/javan/whenever
