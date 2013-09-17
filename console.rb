require 'sqlite3'
require 'active_record'

class Formation < ActiveRecord::Base
  establish_connection(adapter: 'sqlite3', database: 'data.sqlite3', pool: 5)
end


class EnfDB < ActiveRecord::Base
  
  establish_connection(adapter: 'mysql2', database: 'enf_formation', pool: 5, 
                       username: 'root', password: 'admin', socket: '/var/run/mysqld/mysqld.sock')
  self.abstract_class = true
end

class ContratEnf < EnfDB
  self.table_name = 'contrat'
  self.primary_key =  'ID_nat'
end

class ExperienceEnf < EnfDB
  self.table_name = 'experience'
  self.primary_key = 'ID_exp'
end

class Experience2Enf < EnfDB
  self.table_name = 'experience2'
  self.primary_key = 'ID_exp2'
end

class GeoEnf < EnfDB
  self.table_name = 'geo'
  self.primary_key = 'ID_Geo'
end

class GeoZipcodeEnf < EnfDB
  self.table_name = 'geo_zipcode'
  self.primary_key = 'INSEE'
end

class OfferEnf < EnfDB
  self.table_name = 'offer'
  self.primary_key = 'ID'
end

class RegeoEnf < EnfDB
  self.table_name = 'regeo'
  self.primary_key = 'ID_regeo'
end

class SecteurEnf < EnfDB
  self.table_name = 'secteur'
  self.primary_key = 'ID_sec'
end

##### DEP FORMATION ######

class DepDB < ActiveRecord::Base
  
  establish_connection(adapter: 'mysql2', database: 'dep_formation', pool: 5, 
                       username: 'root', password: 'admin', socket: '/var/run/mysqld/mysqld.sock')
  self.abstract_class = true
end

class ContratDep < DepDB
  self.table_name = 'contrat'
  self.primary_key =  'ID_nat'
end

class ExperienceDep < DepDB
  self.table_name = 'experience'
  self.primary_key = 'ID_exp'
end

class Experience2Dep < DepDB
  self.table_name = 'experience2'
  self.primary_key = 'ID_exp2'
end

class GeoDep < DepDB
  self.table_name = 'geo'
  self.primary_key = 'ID_Geo'
end

class GeoZipcodeDep < DepDB
  self.table_name = 'geo_zipcode'
  self.primary_key = 'INSEE'
end

class OfferDep < DepDB
  self.table_name = 'offer'
  self.primary_key = 'ID'
end

class RegeoDep < DepDB
  self.table_name = 'regeo'
  self.primary_key = 'ID_regeo'
end

class SecteurDep < DepDB
  self.table_name = 'secteur'
  self.primary_key = 'ID_sec'
end

