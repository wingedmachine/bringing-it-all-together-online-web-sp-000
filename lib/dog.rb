class Dog
  attr_reader :id, :name, :breed

  def initialize(name:, breed:, id: nil)
    @id = id
    @name = name
    @breed = breed
  end

  def save
    save = <<-SQL
      INSERT INTO dogs (name, breed) VALUES (?, ?)
    SQL

    DB[:conn].execute(save, name, breed)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM dogs")[0][0]
    self
  end

  def self.find_or_create_by(hash)
    find = <<-SQL
      SELECT *
      FROM dogs
      WHERE name = ?
        AND breed = ?
    SQL

    row = DB[:conn].execute(find, hash[:name], hash[:breed])
    if !row.empty?
      Dog.create_from_row(row)
    else
      Dog.create(hash)
    end
  end

  def self.create(hash)
    dog = Dog.new(hash)
    dog.save
  end

  def self.find_by_id(id)
    find = <<-SQL
      SELECT *
      FROM dogs
      WHERE id = ?
    SQL

    row = DB[:conn].execute(find, id).first
    Dog.create_from_row(row)
  end

  def self.create_from_row(row)
    Dog.new({ name: row[1], breed: row[2], id: row[0] })
  end

  def self.create_table
    create = <<-SQL
      CREATE TABLE dogs (
        id INTEGER PRIMARY KEY,
        name TEXT,
        breed TEXT
      )
    SQL

    DB[:conn].execute(create)
  end

  def self.drop_table
    drop = <<-SQL
      DROP TABLE dogs
    SQL

    DB[:conn].execute(drop)
  end
end
