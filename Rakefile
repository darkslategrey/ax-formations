# require "rubygems"
# require "bundler/setup"

require 'sqlite3'
require 'active_record'
require 'yaml'

namespace :db do

  desc "Migrate the db"
  task :migrate do
    # connection_details = YAML::load(File.open('config/database.yml'))
    ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'data.sqlite3')
    ActiveRecord::Migrator.migrate("db/migrate/")
  end

  desc "Create the db"
  task :create do
    # connection_details = YAML::load(File.open('config/database.yml'))
    # admin_connection = connection_details
    # ActiveRecord::Base.establish_connection(admin_connection)
    ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'data.sqlite3')
    ActiveRecord::Base.connection.create_database # (connection_details.fetch('database'))
  end

  desc "drop the db"
  task :drop do
    connection_details = YAML::load(File.open('config/database.yml'))
    # admin_connection = connection_details.merge({'database'=> 'postgres', 
    #                                             'schema_search_path'=> 'public'}) 
    # admin_connection = connection_details
    ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'data.sqlite3')
    # ActiveRecord::Base.establish_connection(admin_connection)
    ActiveRecord::Base.connection.drop_database # (connection_details.fetch('database'))
  end

  task :clean do
    exec 'rm *~'
  end

end

desc "Console"
task :console do
  `pry -r './console.rb'`
end

