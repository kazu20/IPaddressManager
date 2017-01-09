require 'active_record'
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'db/development.sqlite3'
)

class Ipaddresslist < ActiveRecord::Base
end

class Tmplist < ActiveRecord::Base
end
