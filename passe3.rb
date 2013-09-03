require 'open-uri'
require 'nokogiri'
require 'sqlite3'
require 'active_record'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'data.sqlite3')


class Formation < ActiveRecord::Base
end



Formation.all.each { |formation|
  puts "get #{formation.url}"
  doc = Nokogiri::HTML(open(URI.encode(formation.url)))
  outfile = "fiches/#{formation.dest}/#{formation.id}.html"
  File.write(outfile, doc.inner_html)
  break
}
