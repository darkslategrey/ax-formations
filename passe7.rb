# -*- coding: utf-8 -*-

require './console'
require 'nokogiri'
require 'open-uri'
require 'pry'

# 438	www.defi-metiers.fr
def extract_2(formation)

  infile = "details/#{formation.dest}/#{formation.id}.html"
  puts "Extract_2: open #{infile}"
  doc     = Nokogiri::HTML(open(infile))
  content = doc.xpath('//table[@class="offreDetails"]')

  binding.pry
end

# 657	www.rhonealpes-orientation.org
def extract_1(formation)


  infile = "details/#{formation.dest}/#{formation.id}.html"
  puts "Extract_1: open #{infile}"
  doc     = Nokogiri::HTML(open(infile))
  content = doc.xpath('//div[@id="content_onglet1"]')

  begin
    email    = content.xpath('//a[starts-with(@href, "mailto")]').first[:href].split(':')[1]
  rescue Exception => e
    email = 'n/a'
  end

  objectif = content.xpath('//div[@id="vertical_container1"]//text()').map { |e| 
    e.content.strip 
  }.join("\n")
  contenu = content.xpath('//div[@id="vertical_container2"]//text()').map { |e| 
    e.content.strip 
  }.join("\n")

  puts "email:\t#{email}"
  puts "objectif:\t#{objectif}"
  puts "contenu:\t#{contenu}"

  formation.update_columns(email: email, objectif: objectif, contenu: contenu, step: 'step7')

end


# formations = Formation.where('url_orig like ?', '%www.rhonealpes-orientation.org%')
formations = Formation.where('url_orig like ?', '%www.defi-metiers.fr%')
count = formations.count
cpt = 0
formations.each { |f| 
  puts "=========== #{cpt} / #{count} ============"
  if f.url_orig == 'n/a' or f.url_orig == f.url_ets or f.step == 'step7' 
    next
  end
  uri = URI.parse f.url_orig

  case uri.host
  when 'www.rhonealpes-orientation.org'
    extract_1 f
  when 'www.defi-metiers.fr'
    extract_2 f
  # when 'www.formationchampagneardenne.org'
  #   extract_3 f
  # when 'www.formation.gref-bretagne.com'
  #   extract_4 f
  # when 'www.etoile.regioncentre.fr'
  #   extract_5 f
  # when 'www.cariforef-pdl.org'
  #   extract_6 f
  # when 'www.sofia.c2rp.fr'
  #   extract_7 f
  # when 'offre-formation.atout-metierslr.fr'
  #   extract_8 f
  # when 'www.c2r-bourgogne.org'
  #   extract_9 f
  # when 'offredeformation.picardie.fr'
  #   extract_10 f
  # when 'www.formationauvergne.com'
  #   extract_11 f
  # when 'www.trouvermaformation.fr'
  #   extract_12 f
  # when 'offredeformation.crefor-hn.fr'
  #   extract_13 f
  # when 'www.inffolor.org'
  #   extract_14 f
  # when 'www.ares.arftlv.org'
  #   extract_15 f
  # when 'www.efigip.org'
  #   extract_16 f
  # when 'www.fiore-corse.net'
  #   extract_17 f
  else
    puts "Formation #{f.id} #{f.url_orig} NON TRAITÉE"
    next
  end
  cpt += 1
}
    


