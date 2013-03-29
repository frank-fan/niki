fs = require('fs')

exports.get = (wiki, callBack) ->
  console.log 'service get()'
  console.log wiki
  fs.readFile './storage/wiki/' + wiki['slug'] + '.md', "utf8", callBack

#多级目录保存
#sms/index
#sms/ok/index
exports.save = (wiki, callBack) ->
  if (not wiki.slug?) or (wiki.slug.indexOf('/') == 0) or (wiki.slug.indexOf('/') == wiki.slug.length - 1)
    callBack "wiki.slug is not valid"
    return;

  if wiki.slug.indexOf '/' != -1
    dir = './storage/wiki/' + wiki.slug.substr(0, wiki.slug.lastIndexOf('/'))
    fs.mkdirSync(dir) if not fs.existsSync(dir)

  filename = './storage/wiki/' + wiki['slug'] + '.md'
  content = "---\ntitle: #{wiki.title}\nslug: #{wiki.slug}\n---\n\n#{wiki.content}"
  fs.writeFile filename, content, callBack
