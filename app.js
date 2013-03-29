require('coffee-script');

var express = require('express');
var http = require('http');
var routes = require('./app/router');
var config = require('./global').config;

var app = express();
var static_dir = __dirname + '/app/assets';

app.configure(function () {
  app.set('port', config.port);
  app.set('views', __dirname + '/app/views');
  app.set('view engine', 'ejs');
  app.use(express.compress());
  app.use(express.logger('dev'));
  app.use(express.bodyParser());
  app.use(express.cookieParser());
  app.use(express.session({ secret: config.secretKey }));
  app.use(express.favicon(__dirname + '/app/assets/favicon.ico'));
});

app.configure('development', function () {
  app.use(express.static(static_dir));
  app.use(express.errorHandler({
    dumpExceptions: true,
    showStack: true
  }));
});

app.configure('production', function () {
  var one_year = 31557600000;
  app.use(express.static(static_dir, {
    maxAge: one_year
  }));
  app.use(express.errorHandler());
  app.set('view cache', true);
});

routes(app);

http.createServer(app).listen(app.get('port'), function () {
  console.log("niki server listening on port " + app.get('port'));
});
