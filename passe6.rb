# -*- coding: utf-8 -*-


require './console'
require 'nokogiri'
require 'open-uri'
require 'pry'

# 657	www.rhonealpes-orientation.org
# 438	www.defi-metiers.fr
# 332	www.formationchampagneardenne.org
# 283	www.formation.gref-bretagne.com
# 235	www.etoile.regioncentre.fr
# 193	www.cariforef-pdl.org
# 191	www.sofia.c2rp.fr
# 138	offre-formation.atout-metierslr.fr
# 118	www.c2r-bourgogne.org
# 106	offredeformation.picardie.fr
# 104	www.formationauvergne.com
# 67	www.aquitaine-cap-metiers.fr
# 63	www.trouvermaformation.fr
# 60	offredeformation.crefor-hn.fr
# 35	www.inffolor.org
# 33	www.prisme-limousin.fr
# 30	www.ares.arftlv.org
# 18	www.efigip.org
# 11	www.fiore-corse.net
# 1	www.ch-bernay.fr%20-%20rubrique%20Le%20centre%20hospitalier
# total des fiches à parser 3114
# total des fiches à parser sorted 3113
# total des type de fiches à parser 20

url_orig = {}
ids = []
to_parse = {}
Formation.all.order(:url_orig).each { |f| 

  if f.url_orig == 'n/a' or f.url_orig == f.url_ets or url_orig.key? url_orig
    next
  end
  url_orig[f.url_orig] = 1

  ids << f.id
  uri = URI.parse f.url_orig
  cpt = to_parse[uri.host] || 0
  to_parse[uri.host] = cpt + 1
  # puts "#{f.id} #{f.url_orig} #{f.url_ets}" 
}

total = 0
to_parse_inverted = to_parse.invert
sorted_keys = to_parse_inverted.keys.sort { |a,b| b <=> a }
sorted_keys.each { |k|
  puts "#{k}\t#{to_parse_inverted[k]}"
  total += k
}
puts ids.count
puts total
puts sorted_keys.size
