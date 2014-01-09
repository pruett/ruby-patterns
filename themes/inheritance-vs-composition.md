Inheritance Versus Composition
==============================

### Inheritance

Inheritance is a core concept in object oriented code. It generally describes a *is a kind of* relationship.

```ruby
class A
  def hello; puts "hello"; end
  def goodbye; puts "goodbye"; end
end

class B < A
  def yo; puts "yo"; end
end

A.new.hello #=> "hello"
B.new.hello #=> "hello"
B.new.goodbye #=> "goodbye"
B.new.yo #=> "yo"
A.new.yo #=> undefined method `yo'
```

Above we declare two `Class` objects, `A` and `B`. We define `B` as a **subclass** of a `A` with the inheritance notation `B < A`. This provides `B` with all of the behavior of `A`. In our case, `B` *inherits* both the *hello* and *goodbye* methods automatically.

While inheritance shines in its ability to extend objects effortlessly, maintain code hierarchy, and keep code *DRY*. However, there is no denying the tight coupling that exists between **subclass** `B` to its **superclass** `A`.

Imagine `A`'s behavior evolving over time, and how it will effect its subclasses. This is a big consideration when dealing with inheritance. Often, superclasses support mulitple subclasses and complexity increases even further; a simple change in functionality could tricle down and break previous functionality. This is where inheritance starts to decay.

### Composition

Composition provides an alternative to inheritance when structuring code. It typically illustrates a *has a* relationship between objects.

Composition aims at solving the pitfalls of inheritance through *encapsualtion*, *de-coupling*, and *delegation*. Instead of the tightly coupled objects sometimes created as a result inheritance, composition allows us to keep objects independent of each other, without fear of indirectly affecting dependent objects.

```ruby
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
```

This example above, albeit quite contrived, examines some core components of composition. First, notice we have solid **encapsulation** in our `Class` objects by avoiding any direct inheritance. Second, it is `Mobility`'s responsiblity to provide a clean interface, as it's `Bear` and `Crab`'s duty to properly interact with it. The objects are fully **de-coupled** and instances of `Bear` and `Crab` **delegate** responsibility onto `Mobility`.

## Inheritance vs. Composition

The question of whether to use inheritance or composition typically depends on the situation. Both serve similar functions, but result in very different outcomes. It's often easiest to ask yourself, "is *y* a kind of *x*?". If the answer is yes, look to abstract the essense of *x* and create subclasses that inherit its behavior.

Conversely, if the relationship is less hierarchical, reaching for composition is usually a good bet. Composition tends to provide more flexibility and extensibility, which is always a good thing when dealing with code attempting to model around a future which is largely unknown and in constant flux.




