fs = require 'fs'

#Post a new wiki
#TODO Same name is added ?
#TODO add name to map.json
exports.post = (name, data) ->
  fs.writeFileSync("./storage/#{name}.md", data)

#Read data by given a wiki name
exports.read = (name) ->
  return fs.readFileSync("./storage/#{name}.md").toString()

#Read map of wiki system
exports.readMap = () ->
  return fs.readFileSync("./storage/map.json").toString()