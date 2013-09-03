
require 'active_record'



ActiveRecord::Base.establish_connection(
  adapter:  'mysql2',
  host:     'localhost',
  username: 'root',
  password: 'admin',
  database: 'enf_formation'
)


class Contrat < ActiveRecord::Base
  self.table_name = 'contrat'
end
class Experience < ActiveRecord::Base
  self.table_name = 'experience'
end
class Experience2 < ActiveRecord::Base
  self.table_name = 'experience2'
end

class Geo < ActiveRecord::Base
  self.table_name = 'geo'
end

class GeoZipcode < ActiveRecord::Base
  self.table_name = 'geo_zipcode'
end

class Offer < ActiveRecord::Base
  self.table_name = 'offer'
end


class Regeo < ActiveRecord::Base
  self.table_name = 'regeo'
end

class Secteur < ActiveRecord::Base
  self.table_name = 'secteurs'
end




