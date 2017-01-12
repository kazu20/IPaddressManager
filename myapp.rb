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
  @Registlist = Ipaddresslist.all
  @Registlist.each_with_index do |updatelist, i|
    memo_index = "memo" + i.to_s
    check_index = "check" + i.to_s
    select_ipaddress = "select" + i.to_s
    if params[memo_index] then
      ret = Ipaddresslist.find_by(:ipaddr => params[select_ipaddress])
      ret.memo = params[memo_index]
      ret.save
    end

    if params[check_index] then
      ret = Ipaddresslist.find_by(:ipaddr => params[select_ipaddress])
      ret.destroy
    end
  end
  redirect to('/registered')
end
