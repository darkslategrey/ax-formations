

require 'levenshtein-ffi'


s1 = 'http://offre-formation.atout-metierslr.fr/formation_fiche.aspx?id_action=148727'
s2 = 'http://offre-formation.atout-metierslr.fr/formation_fiche.aspx?id_action=165336'

puts Levenshtein.distance(s1, s2)
