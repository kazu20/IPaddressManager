require 'active_record'
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'db/development.sqlite3'
)

class Ipaddresslist < ActiveRecord::Base
end

class Tmplist < ActiveRecord::Base
end

class NetworkAdministrator

  def getArpList
    arpList = []
    ret  = `./get_arp.sh`
    retEachLine = ret.chomp.split("\n")

    retEachLine.each do |eachLine|
      arpList << eachLine.chomp.split("\t")
    end

    arpList.each do |iplist|
      tmplist = Tmplist.new(:ipaddr  => iplist[0],
                            :macaddr => iplist[1],
                            :maker   => iplist[2],
                            :memo    => iplist[3])
      tmplist.save unless Tmplist.find_by(ipaddr: iplist[0])
    end
    return arpList
  end

  def getRegisteredIPAddress
    ipaddresslist = Ipaddresslist.all
    regist_hash = []
    ipaddresslist.each do |r|
      regist_hash << { :ipaddr  => IPAddr.new(r.ipaddr),
                        :macaddr => r.macaddr,
                        :maker   => r.maker,
                        :memo    => r.memo }
    end
    regist_hash.sort! do |a,b|
      a[:ipaddr] <=> b[:ipaddr]
    end
    return regist_hash
  end

  def setRegisterdIPaddress(params)
    save = Tmplist.all
    save.each_with_index do |savelist, i|
      memo_index = "memo" + i.to_s
      unless params[memo_index].blank? then
        ipaddresslist = Ipaddresslist.new(:ipaddr  => savelist.ipaddr,
                                          :macaddr => savelist.macaddr,
                                          :maker   => savelist.maker,
                                          :memo    => params[memo_index])
        ipaddresslist.save unless Ipaddresslist.find_by(ipaddr: savelist.ipaddr)
      end
  end

  Tmplist.delete_all
  end

  def deleteIPAddress(params)
  end

  def modifyIPAddress(params)
  end

end
