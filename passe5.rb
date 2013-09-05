require 'open-uri'
require 'nokogiri'
require 'sqlite3'
require 'active_record'
require 'pry'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'data.sqlite3', pool: 5)


class Formation < ActiveRecord::Base
end





count = Formation.count
cpt = 0

Formation.all.each { |formation|
  puts "\n================== #{cpt}/#{count} ===============\n"
  cpt += 1

  outfile = "details/#{formation.dest}/#{formation.id}.html"
  next if File.exists? outfile 

  url = formation.url_orig

  if url == 'n/a'
    url = formation.url_ets
  end



  begin
    puts "Getting #{url}"
    doc = Nokogiri::HTML(open(URI.encode(url)))
    puts "Write to #{outfile}"
    File.write(outfile, doc.inner_html)
  rescue Exception => e
    puts "Exception: #{e}"
  end

}
