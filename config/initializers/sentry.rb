require 'sentry-raven'

Raven.configure do |config|
  config.dsn = 'https://8c7a7a48bd0647b5a2ca696fce99c288:a30b3796c0184658822e42ae53a961ec@app.getsentry.com/88349'
  config.environments = ['staging', 'production']
end
