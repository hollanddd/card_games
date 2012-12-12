require 'rubygems'
require 'bundler'

Bundler.require

$LOAD_PATH.unshift 'lib'
require 'sinatra_fishing'
run SinatraFishing
