require 'sinatra'
require './arplist.rb'
require './model/Ipaddresslist.rb'
require 'sinatra'
require 'active_record'
require 'ipaddr'

get '/' do
  erb :index
end

get '/scan' do
  na = NetworkAdministrator.new
  view = na.getArpList
  erb :scan, :locals => {:view => view}
end

get '/registered' do
  na = NetworkAdministrator.new
  regist_hash = na.getRegisteredIPAddress

  erb :registered, :locals => {:registlist => regist_hash}
end

post '/save' do
  na = NetworkAdministrator.new
  na.setRegisterdIPaddress(params)

  redirect to('/registered')
end

post '/update' do
  na = NetworkAdministrator.new
  na.updateIPAddress(params)

  redirect to('/registered')
end
