class Dog

  attr_accessor :name, :breed, :id

  def initialize (name:, breed:, id:nil)
    @name = name
    @breed = breed
    @id = id
  end

  def self.create
    Dog.new
  end


  def save
    new_dog = Dog.new
    self.save

  end

  def self.create_table
    sql =  <<-SQL
      CREATE TABLE IF NOT EXISTS dogs (
        id INTEGER PRIMARY KEY,
        name TEXT,
        breed TEXT
        )
        SQL

    DB[:conn].execute(sql)
  end

  def self.save(name, breed, db)
    db.execute("INSERT INTO dog (name,breed) VALUES (?,?);",name, breed)
    DB[:conn].execute(sql, self.name, self.breed)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM dogs ")[0][0]
  end


  def drop_table
    self.drop_table
  end

  def self.new_from_db(row)
    self.id = row[0]
    self.name = row[1]
    self.breed = row[2]
    dog =self.new(id, name, breed)
    dog
  end
end


  def self.find_by_name(name)
    sql = <<-SQL
     SELECT * FROM dogs WHERE name = ?
     LIMIT 1
   SQL
   DB[:conn].execute(sql, name).map do |row|
     self.new_from_db(row)
   end.first
 end

  def self.find_by_id(id)
   dog_from_db = db.execute("SELECT * FROM dog WHERE id =?;", id).flatten
   Dog.create(name: dog_from_db[0], id: dog_from_db[1], breed: dog_from_db[2], db: db)
 end
