class Dog
  attr_reader :id. :name, :breed

  def initialize(name, breed, id = nil)
    @id = id
    @name = name
    @breed = breed
  end

  def self.create_table
    create = <<-SQL
      CREATE TABLE dogs (
        id INTEGER PRIMARY KEY,
        name TEXT,
        breed TEXT
      )
    SQL

    DB[:conn].execute(sql)  
  end

  def self.drop_table
    drop = <<-SQL
      DROP TABLE doggs
    SQL

    DB[:conn].execute(sql)  
end
