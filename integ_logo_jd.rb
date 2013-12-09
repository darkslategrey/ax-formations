# -*- coding: utf-8 -*-


require 'pp'
require './console'

conf = { 
  'je' => { 'conffile' => '/home/greg/WORK/AUXILIAE/dolibarr.jobenfance/htdocs/conf/conf.php' },
  'jd' => { 'conffile' => '/home/greg/WORK/AUXILIAE/dolibarr.jobdependance/htdocs/conf/conf.php' },
  'logos_dir' => '/home/greg/WORK/AUXILIAE/ax-formations/logos',
  'logo_je' => '/home/greg/WORK/AUXILIAE/ax-formations/images/logo_jobenfance_formation.gif',
  'logo_jd' => '/home/greg/WORK/AUXILIAE/ax-formations/images/logo_jobdependance_formation.gif'
}

je_docs_dir = jd_docs_dir = ''

# ou place t'on les docs
['je', 'jd'].each { |key|
  File.new(conf[key]['conffile']).readlines.each { |line|
    if line =~ /^\$dolibarr_main_data_root/
      conf[key]['docs_dir'] = line.split('=')[1].gsub(/[";]/, '').chomp
    end
  }
}

pp conf

# creation du rep documents/id_tier/thumb
Formation.where.not(:id_doli => nil).where(:dest => 'jd').map { |f| f.id_doli }.each { |tiers_id|
  next if tiers_id.nil?
  puts "tiers_id <#{tiers_id}>"
  tiers = LlxSocJd.find(tiers_id)
  if tiers.nil?
    puts "ATTENTION #{tiers_id} introuvable"
    break
  end

  if tiers.logo !~ /\//
    logo_file_dest = tiers.logo
    logo_file_src  = "#{tiers.logo}?1325762216"
  else
    logo_file_dest = tiers.logo.split('/')[1].split('?')[0]
    logo_file_src  = tiers.logo.split('/')[1]
  end

  dest_dir = "#{conf['jd']['docs_dir']}/societe/#{tiers_id}/logos"

  if File.exists? "#{dest_dir}/#{logo_file_dest}"
    puts "EXIST #{dest_dir}/#{logo_file_dest}"
    next
  end
  # copie du fichier de logo à l'endroit approprié

  thumb_dir = "#{conf['jd']['docs_dir']}/societe/#{tiers_id}/logos/thumbs"

  puts "mkdir -p #{dest_dir}"
  `mkdir -p #{dest_dir}`
  puts "cp #{conf['logos_dir']}/#{logo_file_src} #{dest_dir}/#{logo_file_dest}"
  `cp #{conf['logos_dir']}/#{logo_file_src} #{dest_dir}/#{logo_file_dest}`

  # maj du logo du tiers  
  puts "tiers.update_columns(logo: #{logo_file_dest})"
  tiers.update_columns(logo: logo_file_dest)
  
}


# creation du rep documents/id_tier/thumb
# Formation.where(:dest => 'jd').map { |f| f.id_doli }.each { |tiers_id|
#   next if tiers_id.nil?
#   puts "tiers_id <#{tiers_id}>"
#   tiers = LlxSocJd.find(tiers_id)
#   if tiers.nil?
#     puts "ATTENTION #{tiers_id} introuvable"
#     break
#   end

#   if tiers.logo !~ /\//
#     logo_file_dest = tiers.logo
#     logo_file_src  = "#{tiers.logo}?1325762216"
#   else
#     logo_file_dest = tiers.logo.split('/')[1].split('?')[0]
#     logo_file_src  = tiers.logo.split('/')[1]
#   end

#   dest_dir = "#{conf['jd']['docs_dir']}/societe/#{tiers_id}/logos"

#   if File.exists? "#{dest_dir}/#{logo_file_dest}"
#     puts "EXIST #{dest_dir}/#{logo_file_dest}"
#     next
#   end
#   # copie du fichier de logo à l'endroit approprié

#   thumb_dir = "#{conf['jd']['docs_dir']}/societe/#{tiers_id}/logos/thumbs"

#   puts "mkdir -p #{dest_dir}"
#   `mkdir -p #{dest_dir}`
#   puts "cp #{conf['logos_dir']}/#{logo_file_src} #{dest_dir}/#{logo_file_dest}"
#   `cp #{conf['logos_dir']}/#{logo_file_src} #{dest_dir}/#{logo_file_dest}`

#   # maj du logo du tiers  
#   puts "tiers.update_columns(logo: #{logo_file_dest})"
#   tiers.update_columns(logo: logo_file_dest)
  
# }




