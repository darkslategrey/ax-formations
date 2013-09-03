require 'open-uri'
require 'nokogiri'
require 'sqlite3'
require 'active_record'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'data.sqlite3')


class Formation < ActiveRecord::Base
end



def extract(file, dest)
  filename = file.split('/')[-1]
  categorie = filename.split('_')[0]
  doc = Nokogiri::HTML(open(file))
  table = doc.xpath('//table[@class="search_results_table"]')
  table.xpath('//tr').each do |tr|
    tds = tr.xpath('td')
    next if tds.size == 0
    puts '=============='
    puts "#{tds}\n\n"
    numero, titre, niveau, lieux, region = tds.map { |e| e } #.inner_text.strip }
    # puts "elements #{lieux.children[2]}"

    begin
      niveau   = niveau.content
      addresse = lieux.children[0].content
      region   = region.content
      numero   = numero.content
      cp       = lieux.children[2].content.split(' ')[0]
      ville    = lieux.children[2].content.split(' ')[1..-1].join(' ')
      # intitule = titre.children[0].content
      intitule, ets      = titre.children[1].content.split("\n")
      intitule.strip!
      url      = titre.css('a').first[:href]
      puts "numero %%#{numero}%%\nintitule %%#{intitule}%%\nniveau %%#{niveau}%%\ncp %%#{cp}%%\nville %%#{ville}%%\nets %%#{ets}%%\nurl %%#{url}%%\nregion %%#{region}%%\naddresse %%#{addresse}%%\ncategorie %%#{categorie}%%\ndest %%#{dest}%%"
      Formation.find_or_create_by_url(numero: numero, intitule: intitule, niveau: niveau, addresse: addresse, region: region, url: url, cp: cp, ville: ville, ets: ets, categorie: categorie, dest: dest).save!
    rescue Exception => e
      puts e
      break
    end
    # binding.pry
    # break
  end
end



%w(jd).each do |dir|
  puts dir
  Dir.entries(dir).each do |file|
    next if file =~ /^\./
    puts file
    extract(dir + '/' + file, dir)
  end
  break
end

