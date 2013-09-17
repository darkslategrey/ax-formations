require 'sqlite3'
require 'active_record'

class Formation < ActiveRecord::Base
  establish_connection(adapter: 'sqlite3', database: 'data.sqlite3', pool: 5)
end


class JeDB < ActiveRecord::Base
  
  establish_connection(adapter: 'mysql2', database: 'enf_formation', pool: 5, 
                       username: 'root', password: 'admin', socket: '/var/run/mysqld/mysqld.sock')
  self.abstract_class = true
end

class ContratJe < JeDB
  self.table_name = 'contrat'
  self.primary_key =  'ID_nat'
end

class ExperienceJe < JeDB
  self.table_name = 'experience'
  self.primary_key = 'ID_exp'
end

class Experience2Je < JeDB
  self.table_name = 'experience2'
  self.primary_key = 'ID_exp2'
end

class GeoJe < JeDB
  self.table_name = 'geo'
  self.primary_key = 'ID_Geo'
end

class GeoZipcodeJe < JeDB
  self.table_name = 'geo_zipcode'
  self.primary_key = 'INSEE'
end

class OfferJe < JeDB
  self.table_name = 'offer'
  self.primary_key = 'ID'
end

class RegeoJe < JeDB
  self.table_name = 'regeo'
  self.primary_key = 'ID_regeo'
end

class SecteurJe < JeDB
  self.table_name = 'secteur'
  self.primary_key = 'ID_sec'
end

##### DEP FORMATION ######

class JdDB < ActiveRecord::Base
  
  establish_connection(adapter: 'mysql2', database: 'dep_formation', pool: 5, 
                       username: 'root', password: 'admin', socket: '/var/run/mysqld/mysqld.sock')
  self.abstract_class = true
end

class ContratJd < JdDB
  self.table_name = 'contrat'
  self.primary_key =  'ID_nat'
end

class ExperienceJd < JdDB
  self.table_name = 'experience'
  self.primary_key = 'ID_exp'
end

class Experience2Jd < JdDB
  self.table_name = 'experience2'
  self.primary_key = 'ID_exp2'
end

class GeoJd < JdDB
  self.table_name = 'geo'
  self.primary_key = 'ID_Geo'
end

class GeoZipcodeJd < JdDB
  self.table_name = 'geo_zipcode'
  self.primary_key = 'INSEE'
end

class OfferJd < JdDB
  self.table_name = 'offer'
  self.primary_key = 'ID'
end

class RegeoJd < JdDB
  self.table_name = 'regeo'
  self.primary_key = 'ID_regeo'
end

class SecteurJd < JdDB
  self.table_name = 'secteur'
  self.primary_key = 'ID_sec'
end




##### DOLI JE #####

class DoliJe < ActiveRecord::Base
  
  establish_connection(adapter: 'mysql2', database: 'jobenfance', pool: 5, 
                       username: 'root', password: 'admin', socket: '/var/run/mysqld/mysqld.sock')
  self.abstract_class = true
end


class LlxCDepJe < DoliJe
  self.table_name = 'llx_c_departements'
  self.primary_key = 'rowid'

  has_many :llx_soc_je, :class_name => 'LlxSocJe', :foreign_key => 'fk_departement'
end

class LlxSocJe < DoliJe
  self.table_name = 'llx_societe'
  self.primary_key = 'rowid'

  belongs_to :llx_c_departement, :class_name => 'LlxCDepJe', :foreign_key => 'fk_departement'
  has_one :llx_cat_soc_je, :class_name => 'LlxCatSocJe', :foreign_key => 'fk_societe'
  has_one :llx_cat_je, :class_name => 'LlxCatJe', :through => :llx_cat_soc_je
end


class LlxCatJe < DoliJe
  self.table_name = 'llx_categorie'
  self.primary_key = 'rowid'
  self.inheritance_column = 'inherit_col' # because of type

  has_many :llx_cat_soc_je, :class_name => 'LlxCatSocJe', :foreign_key => 'fk_categorie'
  has_many :llx_soc_je, :class_name => 'LlxSocJe', :through => :llx_cat_soc_je
  
end

class LlxCatSocJe < DoliJe
  self.table_name = 'llx_categorie_societe'

  belongs_to :llx_cat_je, :class_name => 'LlxCatJe', :foreign_key => 'fk_categorie'
  belongs_to :llx_soc_je, :class_name => 'LlxSocJe', :foreign_key => 'fk_societe'
end



##### DOLI JD #####

class DoliJd < ActiveRecord::Base
  
  establish_connection(adapter: 'mysql2', database: 'jobdependance', pool: 5, 
                       username: 'root', password: 'admin', socket: '/var/run/mysqld/mysqld.sock')
  self.abstract_class = true
end


class LlxCDepJd < DoliJd
  self.table_name = 'llx_c_departements'
  self.primary_key = 'rowid'

  has_many :llx_soc_jd, :class_name => 'LlxSocJd', :foreign_key => 'fk_departement'
end

class LlxSocJd < DoliJd
  self.table_name = 'llx_societe'
  self.primary_key = 'rowid'

  belongs_to :llx_c_departement, :class_name => 'LlxCDepJd', :foreign_key => 'fk_departement'
  has_one :llx_cat_soc_jd, :class_name => 'LlxCatSocJd', :foreign_key => 'fk_societe'
  has_one :llx_cat_jd, :class_name => 'LlxCatJd', :through => :llx_cat_soc_jd
end


class LlxCatJd < DoliJd
  self.table_name = 'llx_categorie'
  self.primary_key = 'rowid'
  self.inheritance_column = 'inherit_col' # because of type

  has_many :llx_cat_soc_jd, :class_name => 'LlxCatSocJd', :foreign_key => 'fk_categorie'
  has_many :llx_soc_jd, :class_name => 'LlxSocJd', :through => :llx_cat_soc_jd
  
end

class LlxCatSocJd < DoliJd
  self.table_name = 'llx_categorie_societe'

  belongs_to :llx_cat_jd, :class_name => 'LlxCatJd', :foreign_key => 'fk_categorie'
  belongs_to :llx_soc_jd, :class_name => 'LlxSocJd', :foreign_key => 'fk_societe'
end
