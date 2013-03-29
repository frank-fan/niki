#mocha --compilers coffee:coffee-script

chai = require 'chai'
assert = chai.assert
should = chai.should()

fs = require 'fs'

service = require '../app/service/wiki'

describe 'Test save', ->
  describe '#save', ->
    it '单级文件保存， 当slug为文件名时，直接保存文件slug.md在storage目录下', ->
      wiki =
        slug: "index"
        title: "首页"
        content: "这是内容哈哈哈"

      service.save wiki, (err, data)->
        should.not.exist err
        wiki_file = "./storage/wiki/#{wiki.slug}.md"
        console.log wiki_file
        assert.isTrue fs.existsSync(wiki_file), "文件#{wiki_file}不存在"

    it '多级文件保存测试', ->
      wiki =
        slug: "sms/index"
        title: "短信"
        content: "这是内容哈哈哈"

      service.save wiki, (err, data) ->
        should.not.exist err
        wiki_file = "./storage/wiki/#{wiki.slug}.md"
        assert.isTrue fs.existsSync(wiki_file), "文件#{wiki_file}不存在"

    it "无效多级目录测试", ->
      wiki =
        slug: "/sms/index/"
        title: "短信"
        content: "这是内容哈哈哈"

      service.save wiki, (err, data) ->
        should.exist err

      wiki.slug = "/"
      service.save wiki, (err, data) ->
        should.exist err

      wiki.slug = "sms/"
      service.save wiki, (err, data) ->
        should.exist err