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

