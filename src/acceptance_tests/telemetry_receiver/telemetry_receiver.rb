#!/usr/bin/env ruby

require 'webrick'
require 'json'
require 'yajl'

server = WEBrick::HTTPServer.new :Port => 8080
server.mount_proc '/' do |req, res|
  parser = Yajl::Parser.new
  parser.on_parse_complete = Proc.new do |obj|
    WEBrick::BasicLog.new.info({"body": obj, "headers": req.header}.to_json)
  end
  parser.parse(req.body)
end
server.start
