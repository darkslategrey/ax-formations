# -*- coding: utf-8 -*-

require './console'
require 'nokogiri'
require 'open-uri'
require 'pry'

# 191	www.sofia.c2rp.fr
def extract_7(formation)
  infile = "details/#{formation.dest}/#{formation.id}.html"
  puts "Extract_7: open #{infile}"
  doc     = Nokogiri::HTML(open(infile))

  # content = doc.xpath('//div[@id = "idDivContenu"]').first
  # binding.pry

  begin 
    objectif = doc.xpath('//span[text() = "Objectifs :"]').first.parent.parent.next.text
  rescue Exception => e
    objectif = 'n/a'
  end

  begin 
    contenu = doc.xpath('//span[text() = "Contenu de la formation  :"]').first.parent.parent.next.text
  rescue Exception => e
    contenu = 'n/a'
  end

  begin
    # email    = doc.xpath('//table[@class = "ficheresultat_coordonnee"]/a[starts-with(@href, "mailto")]').first[:href].split(':')[1]
    email    = doc.xpath('//a[starts-with(@href, "mailto")]').first[:href].split(':')[1]
  rescue Exception => e
    email = 'n/a'
  end

  email.strip!
  objectif.strip!
  contenu.strip!

  puts "email:\t%#{email}%"
  # puts "objectif:\t%#{objectif}%"
  # puts "contenu:\t%#{contenu}%"

  formation.update_columns(email: email, objectif: objectif, contenu: contenu, step: 'step7')
  # binding.pry

end

# 193	www.cariforef-pdl.org
def extract_6(formation)
  infile = "details/#{formation.dest}/#{formation.id}.html"
  puts "Extract_6: open #{infile}"
  doc     = Nokogiri::HTML(open(infile))

  # content = doc.xpath('//div[@id = "idDivContenu"]').first
  # binding.pry

  begin 
    objectif = doc.xpath('//b[text() = "Objectifs :"]').first.parent.parent.next.next.text
  rescue Exception => e
    objectif = 'n/a'
  end

  begin 
    contenu = doc.xpath('//b[text() = "Programme :"]').first.parent.parent.next.next.text
  rescue Exception => e
    contenu = 'n/a'
  end

  begin
    # email    = doc.xpath('//table[@class = "ficheresultat_coordonnee"]/a[starts-with(@href, "mailto")]').first[:href].split(':')[1]
    email    = doc.xpath('//a[starts-with(@href, "mailto")]').first[:href].split(':')[1]
  rescue Exception => e
    email = 'n/a'
  end

  email.strip!
  objectif.strip!
  contenu.strip!

  puts "email:\t%#{email}%"
  # puts "objectif:\t%#{objectif}%"
  # puts "contenu:\t%#{contenu}%"

  formation.update_columns(email: email, objectif: objectif, contenu: contenu, step: 'step7')
  # binding.pry

end


# 235	www.etoile.regioncentre.fr
def extract_5(formation)
  infile = "details/#{formation.dest}/#{formation.id}.html"
  puts "Extract_5: open #{infile}"
  doc     = Nokogiri::HTML(open(infile))

  content = doc.xpath('//div[@id = "idDivContenu"]').first
  # binding.pry

  begin 
    objectif = content.xpath('//u[text() = "Objectif : "]').first.parent.parent.next.next.text
  rescue Exception => e
    objectif = 'n/a'
  end

  begin 
    contenu = content.xpath('//u[text() = "Programme : "]').first.parent.parent.next.next.text
  rescue Exception => e
    contenu = 'n/a'
  end

  begin
    # email    = doc.xpath('//table[@class = "ficheresultat_coordonnee"]/a[starts-with(@href, "mailto")]').first[:href].split(':')[1]
    email    = doc.xpath('//a[starts-with(@href, "mailTo")]').first[:href].split(':')[1]
  rescue Exception => e
    email = 'n/a'
  end

  email.strip!
  objectif.strip!
  contenu.strip!

  puts "email:\t%#{email}%"
  # puts "objectif:\t%#{objectif}%"
  # puts "contenu:\t%#{contenu}%"

  formation.update_columns(email: email, objectif: objectif, contenu: contenu, step: 'step7')
  # binding.pry

end


# 283	www.formation.gref-bretagne.com
def extract_4(formation)
  infile = "details/#{formation.dest}/#{formation.id}.html"
  puts "Extract_4: open #{infile}"
  doc     = Nokogiri::HTML(open(infile))

  # binding.pry
  objectif = ''

  begin 
    obj = doc.xpath('//strong[text() = "Objectifs "]').first
    obj = obj.next
    while obj.name != 'img'
      if obj.name == 'br'
        objectif += "\n"
      else
        objectif += obj.text
      end
      obj = obj.next
    end
  rescue Exception => e
    puts "Exception #{e}"
    objectif = 'n/a'
  end
  objectif.strip!
  # begin 
  #   contenu = doc.xpath('//td[text() = "Programme :"]').first.parent.xpath('td').last.text
  # rescue Exception => e
  #   contenu = 'n/a'
  # end

  begin
    email    = doc.xpath('//a[starts-with(@href, "mailto")]').first[:href].split(':')[1]
  rescue Exception => e
    email = 'n/a'
  end

  puts "email:\t%#{email}%"
  puts "objectif:\t%#{objectif}%"
  # puts "contenu:\t%#{contenu}%"
  contenu = ''
  formation.update_columns(email: email, objectif: objectif, contenu: contenu, step: 'step7')


end

# 332	www.formationchampagneardenne.org
def extract_3(formation)
  infile = "details/#{formation.dest}/#{formation.id}.html"
  puts "Extract_3: open #{infile}"
  doc     = Nokogiri::HTML(open(infile))

  begin 
    objectif = doc.xpath('//td[text() = "A quoi prépare cette formation ?"]').first.parent.xpath('td').last.text
  rescue Exception => e
    objectif = 'n/a'
  end

  begin 
    contenu = doc.xpath('//td[text() = "Programme :"]').first.parent.xpath('td').last.text
  rescue Exception => e
    contenu = 'n/a'
  end

  begin
    email    = doc.xpath('//a[starts-with(@href, "mailto")]').first[:href].split(':')[1]
  rescue Exception => e
    email = 'n/a'
  end

  puts "email:\t%#{email}%"
  puts "objectif:\t%#{objectif}%"
  puts "contenu:\t%#{contenu}%"

  formation.update_columns(email: email, objectif: objectif, contenu: contenu, step: 'step7')
  # binding.pry

end

# 438	www.defi-metiers.fr
def extract_2(formation)

  infile = "details/#{formation.dest}/#{formation.id}.html"
  puts "Extract_2: open #{infile}"
  doc     = Nokogiri::HTML(open(infile))
  content = doc.xpath('//table[@class="offreDetails"]')

  begin
    objectif = content.xpath('//td[text() = "Objectif"]').first.next_sibling.text
  rescue Exception => e
    objectif = 'n/a'
  end
  # contenu  = content.xpath('//td[text() = "Description"]').first.parent.elements.last.text
  # contenu  = content.xpath('//td[text() = "Description"]').first.parent.xpath('//td[@class = "donnees"]')elements.last.text
  begin
    contenu = content.xpath('//td[text() = "Description"]').first.parent.xpath('td[@class = "donnees"]').text
  rescue Exception => e
    contenu = 'n/a'
  end

  # binding.pry

  begin
    email    = content.xpath('//a[starts-with(@href, "mailto")]').first[:href].split(':')[1]
  rescue Exception => e
    email = 'n/a'
  end

  puts "email:\t%#{email}%"
  puts "objectif:\t%#{objectif}%"
  puts "contenu:\t%#{contenu}%"
  
  formation.update_columns(email: email, objectif: objectif, contenu: contenu, step: 'step7')

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
# formations = Formation.where('url_orig like ?', '%www.defi-metiers.fr%')
# formations = Formation.where(:id =>  1608)
# formations = Formation.where('url_orig like ?', '%www.formationchampagneardenne.org%')
# formations = Formation.where('url_orig like ?', '%www.formation.gref-bretagne.com%')
# formations = Formation.where('url_orig like ?', '%www.etoile.regioncentre.fr%')
# formations = Formation.where('url_orig like ?', '%www.cariforef-pdl.org%')
formations = Formation.where('url_orig like ?', '%www.sofia.c2rp.fr%')

count = formations.count
cpt = 0
formations.each { |f| 
  cpt += 1
  puts "=========== #{cpt} / #{count} / #{f.id} ============"
  if f.url_orig == 'n/a' or f.url_orig == f.url_ets or f.step == 'step7' 
    next
  end
  uri = URI.parse f.url_orig

  case uri.host
  when 'www.rhonealpes-orientation.org'
    extract_1 f
  when 'www.defi-metiers.fr'
    extract_2 f
  when 'www.formationchampagneardenne.org'
    extract_3 f
  when 'www.formation.gref-bretagne.com'
    extract_4 f
  when 'www.etoile.regioncentre.fr'
    extract_5 f
  when 'www.cariforef-pdl.org'
    extract_6 f
  when 'www.sofia.c2rp.fr'
    extract_7 f
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

}
    


