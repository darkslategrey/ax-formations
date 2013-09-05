require 'open-uri'
require 'nokogiri'
require 'sqlite3'
require 'active_record'
require 'pry'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'data.sqlite3')


class Formation < ActiveRecord::Base
end


def extract(file)
  filename = file.split('/')[-1]
  id = filename.split('.')[0]

  formation = Formation.find(id)

  return if formation.step == 'step4'

  puts "#{filename} / #{id}"
  doc  = Nokogiri::HTML(open(file))
  begin
    logo = doc.css('img[@class="sourcelogo"]').first[:src]
  rescue Exception => e
    puts "Exception: Pas de logo pour #{filename}"
    logo = 'n/a'
  end

  presentation = doc.xpath('//div[@id="presentation_metier"]')

  puts "=========== PRESENTATION_METIER ======="
  puts presentation
  puts "=========== PRESENTATION_METIER FIN ======="

  niveau   = presentation.first.children.css('p').first.children[0].content.split(':')[1].strip
  duree    = presentation.first.children.css('p').first.children[2].content.split(':')[1].strip

  begin 
    url_orig = presentation.first.children.css('p').last.css('a').first[:href]
  rescue Exception => e
    puts "Exception: Pas d'url pour #{filename}"
    url_orig = 'n/a'
  end

  addresse = doc.xpath('//div[@id="adresse_formation"]/p')

  puts "=========== ADDRESSE ==========="
  puts addresse
  puts "=========== ADDRESSE FIN ==========="

  begin
    tel = addresse[1].children[0].content.split(':')[1].strip
  rescue Exception => e
    puts "Exception: Pas de tel pour #{filename}"
    tel = 'n/a'
  end
  
  begin
    fax = addresse[1].children[2].content.split(':')[1].strip
  rescue Exception => e
    puts "Exception: Pas de fax pour #{filename}"
    fax = 'n/a'
  end

  # binding.pry

  begin
    url_ets = addresse[2].xpath('a').first[:href]
  rescue Exception => e
    puts "Exception: Pas d'url ets pour #{filename}"
    url_ets = 'n/a'
  end

  puts "logo %#{logo}%"
  puts "duree %#{duree}%"
  puts "niveau %#{niveau}%"
  puts "url_orig %#{url_orig}%"
  puts "tel %#{tel}%"
  puts "fax %#{fax}%"
  puts "url_ets %#{url_ets}%"




  if logo != 'n/a'
    logo_out = logo.split('/')[-1]
    if not File.exists? "logos/#{logo_out}"
      puts "get logo #{logo}"  
      `wget http://www.orientation-pour-tous.fr/#{logo} -O logos/#{logo.split('/')[-1]}`
    end
  end

  formation.update_columns(logo: logo, duree: duree, niveau: niveau, url_orig: url_orig, tel: tel, 
                           fax: fax, step: 'step4', url_ets: url_ets)

end

%w(fiches/je fiches/jd).each { |dir|
  puts dir
  Dir.entries(dir).each { |file|
    next if file =~ /^\./
    puts file
    extract "#{dir}/#{file}"
  }
}
