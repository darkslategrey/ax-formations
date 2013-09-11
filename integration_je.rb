# -*- coding: utf-8 -*-


require './console'


def get_niveau(formation)
  id_niveau = ''
  case formation.niveau
  when "Autres"
    id_niveau = Experience.where(:experience => 'Niveau non applicable').first.ID_exp
  when "Bac +2"
    id_niveau = Experience.where(:experience => 'BAC +2/3 (DEUG, Licence, DUT, BTS, Prépas...)').first.ID_exp
  when "Bac +3 et 4"
    id_niveau = Experience.where(:experience => 'BAC +2/3 (DEUG, Licence, DUT, BTS, Prépas...)').first.ID_exp
  when "Bac +5 et plus"
    id_niveau = Experience.where(:experience => 'BAC +5 (DESS, DEA, Master rech. ou pro., Grande Ecole ...)').first.ID_exp
  when "Bac ou équivalent"
    id_niveau = Experience.where(:experience => 'BAC / BAC PRO').first.ID_exp
  when "CAP/BEP ou équivalent"
    id_niveau = Experience.where(:experience => 'BEP').first.ID_exp
  when "Non communiqué"
    id_niveau = Experience.where(:experience => 'Niveau non applicable').first.ID_exp
  when "Seconde sans diplôme"
    id_niveau = Experience.where(:experience => 'Niveau non applicable').first.ID_exp
  end
end

def get_secteur(formation)
  id_sec = ''
  case formation.categorie
  when "aide-médico-psychologique"
    id_sec = Secteur.where(:secteur => "Aide médico-psychologique").first.ID_sec
  when "aide-soignant"
    id_sec = Secteur.where(:secteur => "Santé social").first.ID_sec
  when "animateur-périscolaire"
    id_sec = Secteur.where(:secteur => "Animateur socio-culturel").first.ID_sec
  when "ash"
    id_sec = Secteur.where(:secteur => "Santé social").first.ID_sec
  when "assistant-de-vie-aux-famille"
    id_sec = Secteur.where(:secteur => "Assistant familial").first.ID_sec
  when "atsem"
    id_sec = Secteur.where(:secteur => "ATSEM").first.ID_sec
  when "auxiliaire-de-puériculture"
    id_sec = Secteur.where(:secteur => "Auxiliaire de puériculture").first.ID_sec
  when "auxiliaire-de-vie"
    id_sec = Secteur.where(:secteur => "Santé social").first.ID_sec
  when "avs"
    id_sec = Secteur.where(:secteur => "AVS").first.ID_sec
  when "bafa"
    id_sec = Secteur.where(:secteur => "Animateur socio-culturel").first.ID_sec
  when "bafd"
    id_sec = Secteur.where(:secteur => "Animateur socio-culturel").first.ID_sec
  when "bees"
    id_sec = Secteur.where(:secteur => "Animateur sportif").first.ID_sec
  when "bpjeps"
    id_sec = Secteur.where(:secteur => "Animateur sportif").first.ID_sec
  when "cafdes"
    id_sec = Secteur.where(:secteur => "Directeur centre de loisirs").first.ID_sec
  when "caferuis"
    id_sec = Secteur.where(:secteur => "Directeur centre de loisirs").first.ID_sec
  when "cap-petite-enfance"
    id_sec = Secteur.where(:secteur => "Auxiliaire petite enfance").first.ID_sec
  when "de-puericultrice"
    id_sec = Secteur.where(:secteur => "Puéricultrice").first.ID_sec
  when "deass"
    id_sec = Secteur.where(:secteur => "Assistante sociale").first.ID_sec
  when "defa"
    id_sec = Secteur.where(:secteur => "Animation / Education").first.ID_sec
  when "dejeps"
    id_sec = Secteur.where(:secteur => "Animateur sportif").first.ID_sec
  when "desjep"
    id_sec = Secteur.where(:secteur => "Animateur sportif").first.ID_sec
  when "educateur-jeune-enfant"
    id_sec = Secteur.where(:secteur => "Educateur spécialisé").first.ID_sec
  when "educateur-spécialisé"
    id_sec = Secteur.where(:secteur => "Educateur spécialisé").first.ID_sec
  when "ergothérapeute"
    id_sec = Secteur.where(:secteur => "Santé social").first.ID_sec
  when "infirmier"
    id_sec = Secteur.where(:secteur => "Infirmier").first.ID_sec
  when "kinesitherapeute"
    id_sec = Secteur.where(:secteur => "Santé social").first.ID_sec
  when "licence-pro-d'animation"
    id_sec = Secteur.where(:secteur => "Animation / Education").first.ID_sec
  when "orthophoniste"
    id_sec = Secteur.where(:secteur => "Orthophoniste").first.ID_sec
  when "podologue"
    id_sec = Secteur.where(:secteur => "Santé social").first.ID_sec
  when "psychologue"
    id_sec = Secteur.where(:secteur => "Psychologue").first.ID_sec
  when "psychomotricien"
    id_sec = Secteur.where(:secteur => "Psychomotricien").first.ID_sec
  when "sage-femme"
    id_sec = Secteur.where(:secteur => "Sage Femme").first.ID_sec
  when "technicien-intervention-sociale-et-familiale"
    id_sec = Secteur.where(:secteur => "Santé social").first.ID_sec
  else
    puts "PAS de secteur trouvé"
  end
  id_sec
end

def get_loc(formation)
  ville = formation.ville
  if ville =~ /saint/i
    ville.gsub!(/saint/i, 'ST')
  end
  if ville =~ /^cergy/i
    ville = 'cergy'
  end
  if ville =~ /'/
    ville.gsub!(/'/, ' ')
  end
  if ville =~ /^lyon [0-9]/i
    ville = 'lyon'
  end
  if ville =~ /^paris *[0-9]*/i
    ville = 'paris'
  end
  if ville =~ /MANS \(LE\)/i
    ville = 'LE MANS'
  end
  if ville =~ /berck sur mer/i
    ville = 'berck'
  end
  if ville =~ /^ivry$/i
    ville = 'ivry sur seine'
  end
  if ville =~ /^ST- GIRONS$/i
    ville = 'ST-GIRONS'
  end
  if ville =~ /^[0-9]+ sophia/i
    ville = 'sophia antipolis'
  end
  if ville =~ /HAVRE \(LE\)/i or ville =~ /\(LE\) HAVRE-CENTRE/i
    ville = 'LE HAVRE'
  end
  if ville =~ /cedex/i
    ville.gsub!(/cedex/i, '').strip!
  end
  loc_data = GeoZipcode.where('VILLE like ?', ville.gsub('-', ' '))
  if loc_data.size == 0
    loc_data = GeoZipcode.where(:ZIP => formation.cp)
    if loc_data.size == 0
      loc_data = GeoZipcode.where('REGION like ?', "%#{formation.region}%")
    end
  end
  loc_data
end

# Formation : 
#   intitule: text
#   niveau: text
#   region: text
#   ets: string
#   cp: string
#   ville: string
#   addresse: string
#   categorie: string
#   dest: string
#   logo: string
#   tel: string
#   fax: string
#   email: string
#   duree: string
#   url_ets: string
#   objectif: text
#   contenu: text
# count = Formation.where(:dest => 'jd', :step => "step7").count
count = Formation.where(:dest => 'jd').count
cpt = 0
offers = []
# Formation.where(:dest => 'jd', :step => "step7").each { |formation|
Formation.where(:dest => 'jd').each { |formation|
  cpt += 1
  job_type = get_secteur formation
  id_niveau = get_niveau formation

  adresse = "#{formation.addresse},\n#{formation.cp} #{formation.ville}"
  loc_data = get_loc formation
  if loc_data.size == 0
    form = "#{formation.id}/#{formation.ville}/#{formation.cp}"
    puts "Attention: Pas de loc pour #{form}"
    break
  else
    loc = loc_data.first
  end

  offer = Offer.new(VIS: 1, URG: 2, ID_TYPDET: 1, DATE: DateTime.now, UPDATE: DateTime.now,
                    KELDATE: DateTime.now, TYPE: 7372, JOBTYPE: job_type, TIT: formation.intitule,
                    ENT: formation.ets, CITY: formation.ville, LOC: loc.CODREG, ZIP: formation.cp,
                    REGLOC: loc.CODREG, NAT: 2, DUR: formation.duree, IDTC: 1, IDTP: 0, 
                    EXP: id_niveau, REF: formation.intitule, ADR: adresse, TEL: formation.tel,
                    FAX: formation.fax,  MAIL: formation.email, LNK: formation.url_ets,
                    LOG: formation.logo, GLOB: 0, CONTI: 4)

  
  puts "#{cpt}/#{count}/#{formation.id} - Creation %#{offer.TIT}%"
  begin
    offer.save
  rescue Exception => e
    puts "#{e}"
  else
    formation.update_columns(id_atc: offer.ID)
  end
  # offers << offer


}

puts "#{offers.size} offres"
offers.each { |offer|
  offer.save
}


