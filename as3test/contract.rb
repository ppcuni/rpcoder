#!/usr/bin/env ruby
# encoding: utf-8

$LOAD_PATH.unshift(File.expand_path('../lib', File.dirname(__FILE__)))
require 'rpcoder'
require 'fileutils'

#######################################
# API definition
#######################################

RPCoder.name_space = 'Aiming.TSS.RPC'
RPCoder.api_class_name = 'API'

RPCoder.type "Mail" do |t|
  t.add_field :subject, :String
  t.add_field :body,    :String
  t.add_field :isRead,  :Boolean
  t.add_field :target,  :String #{ :array? => true }
  t.add_field :next,  :Mail
end

RPCoder.function "ggl" do |f|
  f.path        = "/search/:q/:b/"
  f.method      = "GET"
  f.add_return_type :mail, "Mail"
  f.add_return_type :mailList, "Mail", { :array? => true }
  f.add_param  :q, "String"
  f.add_param  :b, :int
  f.add_param  :nya, "String"
  f.add_param  :num, :int
  f.description = 'ggl'
end

RPCoder.function "getMail" do |f|
  f.path        = "/mails/:id" # => ("/mails/" + id)
  f.method      = "GET"
  f.add_return_type :mail, "Mail"
  f.add_param  :id, "int"
  f.description = 'メールを取得'
end

RPCoder.function "sendMail" do |f|
  f.path        = "/mails" # => ("/mails/" + id)
  f.method      = "POST"
  f.add_param  :subject, :String
  f.add_param  :body,    "String"
  f.description = 'メールを送信'
end

RPCoder.function "getError" do |f|
  f.path        = "/error/:statusCode"
  f.method      = "GET"
  f.add_param  :statusCode, :int
  f.description = 'Get Error'
end

dir = File.expand_path('src', File.dirname(__FILE__))
RPCoder.export(dir)
