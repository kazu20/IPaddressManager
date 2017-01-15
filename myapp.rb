require 'sinatra'
require './arplist.rb'
require './model/Ipaddresslist.rb'
require 'sinatra'
require 'active_record'
require 'ipaddr'

before do
  @na = NetworkAdministrator.new
end

get '/' do
  erb :index
end

get '/scan' do
  view = @na.getArpList
  erb :scan, :locals => {:view => view}
end

get '/registered' do
  regist_hash = @na.getRegisteredIPAddress
  erb :registered, :locals => {:registlist => regist_hash}
end

post '/save' do
  @na.setRegisterdIPaddress(params)
  redirect to('/registered')
end

post '/update' do
  @na.updateIPAddress(params)
  redirect to('/registered')
end
