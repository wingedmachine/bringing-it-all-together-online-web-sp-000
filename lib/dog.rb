class Dog
  attr_reader :id. :name, :breed

  def initialize(name, breed, id = nil)
    @id = id
    @name = name
    @breed = breed
  end
end
