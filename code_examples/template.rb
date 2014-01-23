class Template
  def apply
    start
    first
    second
    third
    finish
  end

  def first
    raise 'must implement first() method'
  end

  def second
    raise 'must implement second() method'
  end

  def third
    raise 'must implement third() method'
  end

  def start; end

  def finish; end
end

class Shampoo < Template
  def start
    puts "rinse hair"
  end

  def first
    puts "apply shampoo"
  end

  def second
    puts "clean hair"
  end

  def third
    puts "rinse shampoo from hair"
  end
end

class Conditioner < Template
  def first
    puts "apply conditioner"
  end

  def second
    puts "condition hair"
  end

  def third
    puts "rinse conditioner from hair"
  end

  def finish
    puts "you hair is now silky and smooth"
  end
end

# Shampoo.new.apply
Conditioner.new.apply
