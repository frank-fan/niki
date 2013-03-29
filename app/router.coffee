home = require('./routers/home')

module.exports = (app) ->
  app.get '/edit/:slug' , home.edit
  app.post '/edit' , home.edit
  app.get '/*' , home.index