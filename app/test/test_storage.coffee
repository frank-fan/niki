storage = require '../src/storage.coffee'
assert = require 'assert'
fs = require 'fs'


describe "Storage", () ->
  describe "post and read", () ->
    name = "helloworld"
    data = "This is the wiki data!"

    it "Save to a file by given name", () ->
      storage.post name, data
      assert.equal fs.existsSync("./storage/#{name}.md"), true
      assert.equal fs.readFileSync("./storage/#{name}.md").toString(), data

    # There is a "helloworld.md" file in the "storage"
    it "Read by given a wiki name", () ->
      assert.equal fs.readFileSync("./storage/#{name}.md").toString(), storage.read(name)
