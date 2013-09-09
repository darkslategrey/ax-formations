require 'open-uri'
require 'nokogiri'
require 'sqlite3'
require 'active_record'
require 'pry'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'data.sqlite3', pool: 5)


class Formation < ActiveRecord::Base
end


# http://www.etoile.regioncentre.fr/metier-formation/rechFormation/ficheAction.asp?hiFOR_ID=13040&modeAcces=GRP&username=guest&password=5f4dcc3b5aa765d61d8327deb882cf99&urlFrom=http://www.etoile.regioncentre.fr:80/GIP/cache/bypass/accueiletoile/seformer/formation/rechercheformation;jsessionid=05D6E4A1E0CA4D7F5977C3F99AE2686E

# formations = Formation.where('url_orig like ?', 'http://www.defi-metiers.fr%')
formations = Formation.where('url_orig like ?', 'http://www.etoile.regioncentre.fr%')
# formations = Formation.where('url_orig like ?', 'http://www.formationauvergne.com%')

# formations = Formation.where('url_orig like ?', 'http://www.inffolor.org%')

count = formations.count
cpt = 0

formations.each { |formation|
  cpt += 1
  puts "\n================== #{cpt}/#{count} ===============\n"
  puts formation.url_orig
  next
  outfile = "details-reprise/#{formation.dest}/#{formation.id}.html"
  infile =  "details/#{formation.dest}/#{formation.id}.html"
  # next if File.exists? outfile 
  doc = Nokogiri::HTML(open(infile))
  url = doc.xpath('//iframe').first[:src]
  puts "Setting #{url}"
  formation.update_columns(url_orig: url)
  next
  begin 
    details = Nokogiri::HTML(open(url))
    File.write(outfile, details.inner_html)
    puts "Write #{outfile}"
  rescue Exception => e
    puts "Oups #{e}"
  end

  # break
  # binding.pry
  # doc.xpath('//iframe').first

  # /rechOrganisme/ficheForm.asp?hiFOR_ID=35840&rubCode=14&id=8&menuCode=14
  # query = formation.url_orig.split('url=')[1].gsub('&param=', '?')
  # url = URI.decode "http://sigma.formationauvergne.com#{query}"
  # url = "#{formation.url_orig}&resV=1366&resH=768"
  # url = formation.url_orig
  # begin
  #   puts "Getting #{url}"
  #   `wget '#{url}' -q -O #{outfile}`
  #   # puts "wget #{url} -O #{outfile}"
  #   # doc = Nokogiri::HTML(open(URI.encode(url)))
  #   puts "Write to #{outfile}"
  #   # File.write(outfile, doc.inner_html)
  # rescue Exception => e
  #   puts "Exception: #{e}"
  # end

}
