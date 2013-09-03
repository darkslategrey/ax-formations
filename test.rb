
require 'open-uri'
require 'nokogiri'



@host = 'http://orientation-pour-tous.fr'
@query = 'http://orientation-pour-tous.fr/?page=resultats_offre&search=cap%2Bpetite%2Benfance&filter_region%5B%5D=&filter_niveau_sortie%5B%5D=&filter_metadomain%5B%5D=&valid_postperpage=ok&postperpage=30&valid_postperpage=ok&debut_formations=30000'

@doc = Nokogiri::HTML(open(@query))

