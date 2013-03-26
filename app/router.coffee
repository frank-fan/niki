home = require('./routers/home')

module.exports = (app) ->
  app.get '/' , home.index
  app.get '/about' , home.about