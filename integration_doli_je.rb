# -*- coding: utf-8 -*-

require './console'


# la categorie formation
# fk_parent: 0, label: "Prospect /  formation", type: 2, entity: 1, description: "", fk_soc: nil, visible: 0, import_key: nil>,


cat_formation = LlxCatJe.where(:label => 'Prospect /  formation').first
if cat_formation.nil?
  cat_formation = LlxCatJe.new(fk_parent: 0, label: 'Prospect /  formation', type: 2, entity: 1, 
                               description: "", fk_soc: nil, visible: 0, import_key: nil)
  cat_formation.save
end


cpt = 0
count = Formation.where(:dest => 'je').count
Formation.where(:dest => 'je').each { |f|
  cpt += 1
  puts "#{cpt}/#{count}/#{f.id}"
  departement = LlxCDepJe.where('code_departement like ?', "#{f.cp.sub(/(^..).*/, '\1')}%").first
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
  societe = LlxSocJe.new(statut: 0,
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
                         logo: f.logo)

  begin
    societe.llx_cat_je = cat_formation
    societe.save
    f.update_columns(id_doli: societe.rowid)
    # cat_formation << societe
  rescue ActiveRecord::RecordNotUnique => e
    puts "\t#{f.id} déjà dans la boite"
  rescue ActiveRecord::StatementInvalid => e
    puts "\tATTENTION #{e}"
  end
}
