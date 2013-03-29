wiki_service = require('../service/wiki')

class wiki
  constructor: (@title, @slug, @content) ->
    unless @slug
      @slug = @title

  setTitle: (@title) ->
  setContent: (@content) ->

  getTitle: -> return @title
  getContent: -> return @content

  validate: -> return true;

  get: (cb) ->
    wiki_service.get this, (err, data) =>
      unless err
        # set title, slug, content

        myregexp = /---[\s\S]+?title\s?:([\s\S]+?)slug\s?:([\s\S]+?)---([\s\S]+)/;
        group = data.match(myregexp);

        @title = group[1].replace(/(^\s*)|(\s*$)/g, "")
        @slug = group[2].replace(/(^\s*)|(\s*$)/g, "")
        @content = group[3].replace(/(^\s*)|(\s*$)/g, "")

        cb true
      else
        console.log err
        cb false

  save: (cb) ->
    wiki_service.save this, cb

module.exports = wiki