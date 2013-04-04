wiki = require('../models/wiki')
marked = require('marked')
marked.setOptions({
  gfm: true,
  tables: true,
  breaks: false,
  pedantic: false,
  sanitize: true,
  smartLists: true,
  langPrefix: 'language-'
});

# URL: /
exports.index = (req, res) ->
  slug = req.url.substr 1
  unless slug
    slug = "index"
  wikiModel = new wiki "", slug, ""
  wikiModel.get (result) ->
    if result
      wikiModel.content = marked(wikiModel.content)
      res.render 'index', wikiModel
    else
      res.redirect "/edit/" + slug

# URL: /edit
exports.edit = (req, res) ->
  if req.method is "GET"
    slug = req.url.substr 6
    wikiModel = new wiki "", slug, ""
    wikiModel.get (result) ->
      if result
        res.render "edit", wikiModel
      else
        #the wiki do not exist, set a title
        res.render "edit", wikiModel
  else
    console.log "POST edit."
    wikiModel = new wiki(req.body.title, req.body.slug, req.body.content)
    validate = wikiModel.validate()
    if validate
      wikiModel.save (err) ->
        unless err
          res.redirect "/" + wikiModel.slug
        else
          console.log err
          res.redirect "edit/" + wikiModel.slug

exports.dillinger = (req, res)->
  res.render "dillinger"