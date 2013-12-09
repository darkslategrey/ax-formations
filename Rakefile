# require "rubygems"
# require "bundler/setup"

require 'sqlite3'
require 'active_record'
require 'yaml'

namespace :db do


  desc "Migrate Doli Je db"
  task :migrate_je do
    ActiveRecord::Base.establish_connection(adapter: 'mysql2', database: 'jobenfance', 
                                            username: 'root', password: 'admin',
                                            socket: '/var/run/mysqld/mysqld.sock')
    ActiveRecord::Migrator.migrate("db/migrate_je/")
  end

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

  task :reinit_je do
    sh 'mysqladmin -u root -padmin drop jobenfance'
    sh 'mysqladmin -u root -padmin create jobenfance'
    sh 'cat doli_jobenfance.dump.sql | mysql -u root -padmin jobenfance'
    sh 'cat sql_scripts/alter_soc.sql | mysql -u root -padmin jobenfance'
  end

  task :reinit_jd do
    sh 'mysqladmin -u root -padmin drop jobdependance'
    sh 'mysqladmin -u root -padmin create jobdependance'
    sh 'cat doli_jobdependance.dump.sql | mysql -u root -padmin jobdependance'
    sh 'cat sql_scripts/alter_soc.sql | mysql -u root -padmin jobdependance'
  end

  desc "load data"
  task :load_data do
    sh 'load_data.sh'
    sh 'cat sql_scripts/alter_soc.sql | mysql -u root -padmin jobenfance'
  end


end

desc "Console"
task :console do
  `pry -r './console.rb'`
end

