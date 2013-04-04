home = require('./routers/home')

module.exports = (app) ->
  app.get '/dillinger/*', home.dillinger
  app.get '/edit/*' , home.edit
  app.post '/edit' , home.edit
  app.get '/*' , home.index
