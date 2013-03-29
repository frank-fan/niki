wiki = require('../models/wiki')
marked = require('marked')

# URL: /
exports.index = (req, res) ->
  slug = req.url.substr 1
  unless slug
    slug = "index"
  wikiModel = new wiki "", slug, ""
  wikiModel.get (result) ->
    wikiModel.content = marked(wikiModel.content)

    if result
      res.render 'index', wikiModel
    else
      res.redirect "/edit/" + slug

# URL: /edit
exports.edit = (req, res) ->
  if req.method is "GET"
    wikiModel = new wiki "", req.params.slug, ""
    wikiModel.get (result) ->
      if result
        res.render "edit", wikiModel
      else
        #the wiki do not exist, set a title
        res.render "edit", wikiModel
  else
    wikiModel = new wiki(req.body.title, req.body.slug, req.body.content)
    validate = wikiModel.validate()
    if validate
      wikiModel.save (err) ->
        unless err
          res.redirect "/" + wikiModel.slug
        else
          console.log err
          res.redirect "edit/" + wikiModel.slug