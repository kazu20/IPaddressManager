class Ipaddresslists < ActiveRecord::Migration
  def change
   create_table :tmplists do |t|
    t.string :ipaddr
    t.string :macaddr
    t.string :maker
    t.string :memo
   end
  end
end
