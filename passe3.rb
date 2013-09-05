require 'open-uri'
require 'nokogiri'
require 'sqlite3'
require 'active_record'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'data.sqlite3')


class Formation < ActiveRecord::Base
end

count = Formation.all.count
cpt = 0
Formation.all.each { |formation|
  outfile = "fiches/#{formation.dest}/#{formation.id}.html"
  cpt += 1
  puts "#{cpt}/#{count}"
  next if File.exist? outfile
  puts "get #{formation.url}"
  doc = Nokogiri::HTML(open(URI.encode(formation.url)))
  File.write(outfile, doc.inner_html)

  # break if cpt > 10
}
