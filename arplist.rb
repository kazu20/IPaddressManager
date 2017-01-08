class ArpList
  def getlist
    @arpList = []
    ret  = `./get_arp.sh`
    retEachLine = ret.chomp.split("\n")

    retEachLine.each do |eachLine|
      @arpList << eachLine.chomp.split("\t")
    end
    return @arpList
  end
end
