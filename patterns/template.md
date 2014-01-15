Template Method Pattern
=======================

The *Template Method Pattern* is a straightforward approach where an abstract superclass defines a set of abstract methods that are meant to be overridden by its subclasses.

Consider the example below:

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
```

Above we define a `Template` class that holds a few **abstract methods**, `first`, `second`, and `third`. Each of these abstract methods will `raise` an error, unless defined directly by a subclass. `Template` also defines two more methods, `start` and `finish`, which are optional methods (read: no explicit `raise`), referred to as **hook** methods. Hook methods provide a way to account for variability between implementations.

Lastly, you'll notice that all of these methods are defined within a single *skeletal* method, a **template method** called `apply`, that executes every method in a particular order.

```ruby
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
```

Above, we define a `Shampoo` class that inherits from our `Template` superclass. We override the required, abstract methods, as well as define a hook method, `start`.

```ruby
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
```

Nearly identical implementation pattern as above, `Conditioner` defines its own required abstract methods along with its own hook method, in this case, `finish`

```ruby
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

The power of the **Template Method Pattern** lies in its simple inheritance-based stucture. Once a subclass is defined properly, we simply call the template method, `apply`, and are afforded the convenience of a customized implementation per subclass.
