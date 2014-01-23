class A
  def hello; puts "hello"; end
  def goodbye; puts "goodbye"; end
end

class B < A
  def yo; puts "yo"; end
end

A.new.hello
B.new.hello
B.new.yo
# A.new.yo

class Mobility
  def lumber; puts "lumbering"; end
  def crabwalk; puts "crabwalking"; end
end

class Bear
  def initialize
    @mobility = Mobility.new
  end

  def move
    @mobility.lumber
  end
end

class Crab
  def initialize
    @mobility = Mobility.new
  end

  def move
    @mobility.crabwalk
  end
end

Bear.new.move
Crab.new.move
