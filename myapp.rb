require 'sinatra'
require './arplist.rb'
require './model/Ipaddresslist.rb'
require 'sinatra'
require 'active_record'

get '/' do
  erb :index
end

get '/scan' do
  ret = ArpList.new
  @view =  ret.getlist
  @view.each do |iplist|
    tmplist = Tmplist.new(:ipaddr  => iplist[0],
                          :macaddr => iplist[1],
                          :maker   => iplist[2],
                          :memo    => iplist[3])
    tmplist.save unless Tmplist.find_by(ipaddr: iplist[0])
  end
  erb :scan
end

get '/registered' do
  @Registlist = Ipaddresslist.all
  erb :registered
end

post '/save' do
  @Save = Tmplist.all
  @Save.each_with_index do |savelist, i|
    memo_index = "memo" + i.to_s
    check_index = "check" + i.to_s
    if params[check_index] then
      ipaddresslist = Ipaddresslist.new(:ipaddr  => savelist.ipaddr,
                                        :macaddr => savelist.macaddr,
                                        :maker   => savelist.maker,
                                        :memo    => params[memo_index])
      ipaddresslist.save unless Ipaddresslist.find_by(ipaddr: savelist.ipaddr)
      unless params[memo_index].blank?
         ipaddr = Ipaddresslist.find_by(ipaddr: savelist.ipaddr)
         ipaddr.memo = params[memo_index]
         ipaddr.save
      end
    end
  end

  Tmplist.delete_all
  redirect to('/registered')
end

post '/update' do
  @Registlist = Ipaddresslist.all
  @Registlist.each_with_index do |updatelist, i|
    memo_index = "memo" + i.to_s
    check_index = "check" + i.to_s
    updatelist.memo = params[memo_index]
    updatelist.destroy if params[check_index]
    updatelist.save
  end
  redirect to('/registered')
end
