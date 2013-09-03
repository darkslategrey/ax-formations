# -*- coding: utf-8 -*-

require 'open-uri'
require 'nokogiri'

# 30 par page
# http://orientation-pour-tous.fr/?page=resultats_offre&search=cap%2Bpetite%2Benfance&filter_region%5B%5D=&filter_niveau_sortie%5B%5D=&filter_metadomain%5B%5D=&postperpage=30&valid_postperpage=ok
# page 2:
# http://orientation-pour-tous.fr/?page=resultats_offre&search=cap%2Bpetite%2Benfance&filter_region%5B%5D=&filter_niveau_sortie%5B%5D=&filter_metadomain%5B%5D=&valid_postperpage=ok&postperpage=30&valid_postperpage=ok&debut_formations=30
# page 3:
# http://orientation-pour-tous.fr/?page=resultats_offre&search=cap%2Bpetite%2Benfance&filter_region%5B%5D=&filter_niveau_sortie%5B%5D=&filter_metadomain%5B%5D=&valid_postperpage=ok&postperpage=30&valid_postperpage=ok&debut_formations=60

# cat referentielJE.csv  | awk -F',' '{ print $1 }' | sed -e '1,3d'  -e '/^\*/d'  -e '/^$/d' -e 's/^  *//' -e 's/  *$//' 
# ATTENTION : (ne pas prendre les 5 premiers résultats qui concerne les auxiliaires)
je_terms = "cap petite enfance|Auxiliaire de puériculture|Educateur jeune enfant|DE Puericultrice|Psychologue|Sage femme|BEES|Licence Pro d'animation|BAFA|DEFA|Animateur Périscolaire|DEJEPS|DESJEP|BPJEPS|ATSEM|AVS|BAFD".split('|')

## 
jd_terms = "assistant de vie aux famille|Auxiliaire de vie|Aide soignant|ASH|Ergothérapeute|kinesitherapeute|Podologue|Technicien intervention sociale et familiale|Aide Médico Psychologique|Psychomotricien|DEASS|Infirmier|Educateur spécialisé|Orthophoniste|CAFERUIS|CAFDES".split('|')

# jd_terms = ['podologue']
je_terms.each do |search|
  cpt = 0  
  while true
    outfile = 'je/' + search.downcase.gsub(' ', '-') + "_#{cpt}.html"
    next if File.exist? outfile
    query = 'http://orientation-pour-tous.fr/?page=resultats_offre&search='
    query += search
    query += '&filter_region%5B%5D=&filter_niveau_sortie%5B%5D=&filter_metadomain%5B%5D=&valid_postperpage=ok&postperpage=30&valid_postperpage=ok'
    cpt != 0 and query += "&debut_formations=#{cpt}"
    @doc = Nokogiri::HTML(open(URI.encode(query)))
    break if  @doc.css('table.search_results_table').xpath('//tr').size == 2
    puts "outfile #{outfile}"
    File.write(outfile, @doc.inner_html)
    cpt += 30
  end
end


# je_terms.each do |search|
#   cpt = 0  
#   while true
#     query = 'http://orientation-pour-tous.fr/?page=resultats_offre&search='
#     query += search
#     query += '&filter_region%5B%5D=&filter_niveau_sortie%5B%5D=&filter_metadomain%5B%5D=&valid_postperpage=ok&postperpage=30&valid_postperpage=ok'
#     cpt != 0 and query += "&debut_formations=#{cpt}"
#     @doc = Nokogiri::HTML(open(URI.encode(query)))
#     break if  @doc.css('table.search_results_table').xpath('//tr').size == 2
#     outfile = 'data1/' + search.downcase.gsub(' ', '-') + "_#{cpt}.html"
#     puts "outfile #{outfile}"
#     File.write(outfile, @doc.inner_html)
#     cpt += 30
#   end
# end

# @host = 'http://orientation-pour-tous.fr'
# @query = 'http://orientation-pour-tous.fr/?page=resultats_offre&search=cap%2Bpetite%2Benfance&filter_region%5B%5D=&filter_niveau_sortie%5B%5D=&filter_metadomain%5B%5D=&valid_postperpage=ok&postperpage=30&valid_postperpage=ok&debut_formations=30'

# @doc = Nokogiri::HTML(open(@query))

# File.write('t.html', @doc.inner_html)






