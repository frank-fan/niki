fs = require('fs')

exports.get = (wiki, callBack) ->
  console.log 'service get()'
  console.log wiki
  fs.readFile './storage/wiki/' + wiki['slug'] + '.md', "utf8", callBack

exports.save = (wiki, callBack) ->
  console.log 'service update()'
  console.log wiki
  filename = './storage/wiki/' + wiki['slug'] + '.md'
  content = "---\ntitle: #{wiki.title}\nslug: #{wiki.slug}\n---\n\n#{wiki.content}"
  fs.writeFile filename, content, callBack