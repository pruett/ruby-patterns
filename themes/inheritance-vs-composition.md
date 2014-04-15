# Inheritance Versus Composition

## Inheritance

**Inheritance** generally describes an *is a kind of* relationship between objects. In other words, through **inheritance**, one object is based off of another. This hierarchical implementation acts as an effective mechanism for code reuse.

### Code Example: Inheritance in Action

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

### Code Breakdown

We declare two class objects, `A` and `B`. We define `B` as a **subclass** of a `A` (with the inheritance notation `B < A`). This provides `B` with all of the behavior of `A`. In our case, `B` *inherits* both the `hello` and `goodbye` methods automatically.

#### Pros and Cons

While inheritance shines in its ability to extend objects effortlessly, maintain code hierarchy, and [DRY](http://en.wikipedia.org/wiki/Don't_repeat_yourself) up code, there is no denying the tight coupling that exists between subclass `B` to its superclass `A`.

Imagine `A`'s behavior evolving over time, and how it will affect its subclasses. This is a big consideration when dealing with inheritance. Often, superclasses support multiple subclasses and complexity increases even further; a simple change in functionality could trickle down and break previous functionality. This is where inheritance starts to decay.

## Composition

**Composition** provides an alternative to inheritance. It typically illustrates a *has a* relationship between objects.

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

Bear.new.move #=> lumbering
Crab.new.move #=> crabwalking
```

This example above, albeit quite contrived, examines some core components of composition. First, notice we have solid **encapsulation** in our class objects by avoiding any direct inheritance. Second, it is `Mobility`'s responsibility to provide a clean interface, as it's `Bear` and `Crab`'s duty to properly interact with it. The objects are fully **de-coupled** and instances of `Bear` and `Crab` **delegate** responsibility onto `Mobility`.

## Inheritance vs. Composition

The question of whether to use inheritance or composition typically depends on the situation. Both serve similar functions, but result in very different outcomes.

If you have a simple object hierarchy that answers yes to the question: "is *y* a kind of *x*?", you will likely first abstract the essence of *x* and create subclasses that inherit its behavior. Inheritance shines in simple examples that follow a disciplined path -- non-complex object relationships that build nicely off a defined superclass.

If the relationship is less hierarchical, however, reaching for composition is usually a good bet. Composition tends to provide more flexibility and extensibility, especially when attempting to model your code around a future which is largely unknown and in constant flux.
