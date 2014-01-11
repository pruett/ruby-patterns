Template Method Pattern
=======================

The *Template Method pattern* is a straightforward approach in which a base class defines a set of abstract methods that are expected to be defined by any number of subclasses.

```ruby
class Template
  def apply
    start
    first
    second
    third
    finish
  end

  def first
    raise 'must implement method: first'
  end

  def second
    raise 'must implement method: second'
  end

  def third
    raise 'must implement method: third'
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

Shampoo.new.apply
#=>
rinse hair
apply shampoo
clean hair
rinse shampoo from hair

Conditioner.new.apply
#=>
apply conditioner
condition hair
rinse conditioner from hair
you hair is now silky and smooth
```
The *Template Method pattern* builds an abstract base class complete with its own **template method** -- the `apply` method in our case, which makes calls to various other, methods, referred to as *abstract methods*. They are meant to be overwritten, to provide specific implementation between subclasses. This is the heart of the *Template Method pattern*!

Another thing to note here, is that while the abstract methods, namely the `first`, `second`, and `third` methods are all required (or else it'll `raise` errors), you'll see `Template#start` and `Template#finish` are left blank. These methods, referred to as **hook methods** are ones in which the abstract class supplies as an optional overwrite. *Hook methods* can add a bit of power to an otherwise strict *template method*.
