require('pg')

class Property
  attr_accessor :address, :value, :num_of_bedrooms, :year_built
  attr_reader :id


  def initialize(details)
    @id = details['id'].to_i if details['id']
    @address = details['address']
    @value = details['value'].to_i
    @num_of_bedrooms = details['num_of_bedrooms'].to_i
    @year_built = details['year_built'].to_i
  end

  def save()
    #connect to the database
    db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
    #build an sql command
    sql = "INSERT INTO properties
    (address, value, num_of_bedrooms, year_built)
    VALUES ($1, $2, $3, $4) RETURNING id;"
    #create a values array
    #ordering is important in the array
    values = [@address, @value, @num_of_bedrooms, @year_built]
    #prepare the sql
    db.prepare("save",sql)
    #execute the sql and get the id
    result = db.exec_prepared("save", values)
    #assign the id to the instance
    @id = result[0]['id'].to_i
    db.close()
  end

  def Property.delete_all()
    db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
    sql = "DELETE FROM properties"
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all", [])
    db.close()
  end

  def Property.all()
    db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
    sql = "SELECT * FROM properties"
    db.prepare("all", sql)
    #we want the properties returned to us, therefore store them in a variable
    properties = db.exec_prepared("all", [])
    db.close()
    return properties.map {|property| Property.new(property)}
  end

  def delete()
    db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
    sql = "DELETE FROM properties WHERE id = $1"
    values = [@id]
    db.prepare('delete', sql)
    db.exec_prepared('delete',values)
    db.close
  end

  def update()
    db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
    sql = "UPDATE properties SET
    (address, value, num_of_bedrooms, year_built)
    = ($1, $2, $3, $4) WHERE id = $5
    "
    values = [@address, @value, @num_of_bedrooms, @year_built, @id]
    db.prepare('update',sql)
    db.exec_prepared('update', values)
    db.close
  end

  def Property.find_by_id(id)

    db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
    sql = "SELECT * FROM properties WHERE id = $1;"
    values = [id]
    db.prepare('find_by_id', sql)
    properties = db.exec_prepared('find_by_id', values)
    db.close
    return properties.map {|property| Property.new(property)}
  end

  def Property.find_by_address(address)
    db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
    sql = "SELECT * FROM properties WHERE address = $1"
    values = [address]
    db.prepare('find_by_address',sql)
    properties = db.exec_prepared('find_by_address', values)
    db.close
    result = properties.map {|property| Property.new(property)}
    if result == []
      return nil
    else
      return result
    end
  end


end
