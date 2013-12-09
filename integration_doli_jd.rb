# -*- coding: utf-8 -*-

require './console'


# la categorie formation
# fk_parent: 0, label: "Prospect /  formation", type: 2, entity: 1, description: "", fk_soc: nil, visible: 0, import_key: nil>,


cat_formation = LlxCatJd.where(:label => 'Prospect /  formation').first
if cat_formation.nil?
  cat_formation = LlxCatJd.new(fk_parent: 0, label: 'Prospect /  formation', type: 2, entity: 1, 
                               description: "", fk_soc: nil, visible: 0, import_key: nil)
  cat_formation.save
end

seen = {}
cpt = 0
count = Formation.where(:dest => 'jd').count
Formation.where(:dest => 'jd').order(:ets).each { |f|

  next if f.ets.upcase == 'NON RENSEIGNé'

  if seen[f.to_key].presence
    puts "#{f.ets} déjà vue"
    next
  else
    seen[f.to_key] = 1
  end

  cpt += 1
  puts "#{cpt}/#{count}/#{f.id}"

  departement = LlxCDepJd.where('code_departement like ?', "#{f.cp.sub(/(^..).*/, '\1')}%").first
  if departement.nil?
    puts "Attention departement pour #{f.cp} est nul"
    departement_id = 0
  else
    departement_id = departement.rowid
  end

  tel = f.tel
  # if f.tel =~ /ou/
  #   tel = f.tel.split('ou')[0].strip
  # end
  logo = f.logo.sub('images_spip/', '')

  if logo =~ /\?/
    logo = logo.split(/\?/)[0]
  end

  societe = LlxSocJd.new(statut: 0,
                         tms: DateTime.now,
                         datec: DateTime.now,
                         datea: DateTime.now,
                         nom: f.ets.upcase,
                         entity: 1,
                         # code_client: "FR%06d" % cpt,
                         address: f.addresse,
                         cp: f.cp,
                         ville: f.ville,
                         fk_departement: departement_id,
                         fk_pays: 1,
                         tel: tel,
                         fax: f.fax,
                         url: f.url_ets,
                         email: f.email,
                         fk_currency: 0,
                         note: f.categorie,
                         client: 1,
                         fk_stcomm: 0,
                         fk_user_creat: 1,
                         fk_user_modif: 1,
                         tva_assuj: 1,
                         status: 1,
                         logo: logo)

  begin
    societe.llx_cat_jd = cat_formation
    puts "saving #{societe.nom}"
    societe.save
    f.update_columns(id_doli: societe.rowid)
    # cat_formation << societe
  rescue ActiveRecord::RecordNotUnique => e
    puts "\t#{f.id} déjà dans la boite"
  rescue ActiveRecord::StatementInvalid => e
    puts "\tATTENTION #{e}"
  end
}
