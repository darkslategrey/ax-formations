require 'sqlite3'
require 'active_record'


ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'data.sqlite3')


class Formation < ActiveRecord::Base
end
