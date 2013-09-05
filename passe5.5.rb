require 'open-uri'
require 'nokogiri'
require 'sqlite3'
require 'active_record'
require 'pry'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'data.sqlite3', pool: 5)


class Formation < ActiveRecord::Base
end




# formations = Formation.where('url_orig like ?', 'http://www.defi-metiers.fr%')
# formations = Formation.where('url_orig like ?', 'http://www.etoile.regioncentre.fr%')
# formations = Formation.where('url_orig like ?', 'http://www.formationauvergne.com%')

formations = Formation.where('url_orig like ?', 'http://www.inffolor.org%')

count = formations.count
cpt = 0

formations.each { |formation|
  puts "\n================== #{cpt}/#{count} ===============\n"
  cpt += 1
  outfile = "details-reprise/#{formation.dest}/#{formation.id}.html"
  next if File.exists? outfile 

  # /rechOrganisme/ficheForm.asp?hiFOR_ID=35840&rubCode=14&id=8&menuCode=14
  # query = formation.url_orig.split('url=')[1].gsub('&param=', '?')
  # url = URI.decode "http://sigma.formationauvergne.com#{query}"
  # url = "#{formation.url_orig}&resV=1366&resH=768"
  url = formation.url_orig
  begin
    puts "Getting #{url}"
    `wget '#{url}' -q -O #{outfile}`
    # puts "wget #{url} -O #{outfile}"
    # doc = Nokogiri::HTML(open(URI.encode(url)))
    puts "Write to #{outfile}"
    # File.write(outfile, doc.inner_html)
  rescue Exception => e
    puts "Exception: #{e}"
  end

}
