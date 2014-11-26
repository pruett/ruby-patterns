Inheritance Versus Composition
==============================

## Inheritance

**Inheritance** generally describes an *is a kind of* relationship between objects. In other words, through **inheritance**, one object is based off of another. This hierarchical implementation acts as an effective mechanism for code reuse.

```ruby
class A
  def hello; puts "hello"; end
  def goodbye; puts "goodbye"; end
end

class B < A # B inherits from A
  def yo; puts "yo"; end
end

A.new.hello #=> "hello"
B.new.hello #=> "hello"
B.new.goodbye #=> "goodbye"
B.new.yo #=> "yo"
A.new.yo #=> undefined method `yo'
```

We declare two class objects, `A` and `B`. We define `B` as a **subclass** of a `A`. This provides `B` with all of the behavior of `A`. In our case, `B` *inherits* both the `hello` and `goodbye` methods from its **superclass** `A` automatically.

While inheritance shines in its ability to extend objects effortlessly, maintain code hierarchy, and [DRY](http://en.wikipedia.org/wiki/Don't_repeat_yourself) up code, there is no denying the tight coupling that exists between the `A` and `B` class objects.

For instance, imagine `A`'s behavior evolving over time, and how it could affect any its **subclasses**. This is a something to constantly consider when dealing with inheritance. A simple change in a **superclass**'s functionality could trickle down and break functionality in a **subclass**. This is where inheritance starts to decay.

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

Above, we define a `Mobility` class, with several methods, which we'll use to compose objects with. `Bear` and `Crab` both *inherit* the `Mobility` object by instantiating an instance of `Mobility` within their respective `intialize` methods. From here, they are able to use all of `Mobility`'s capabilities as they see fit...without the confines of traditional inheritance depicted above.

Notice we have solid **encapsulation** in our class objects by avoiding any direct inheritance. It is `Mobility`'s responsibility to provide a clean interface, as it's `Bear` and `Crab`'s duties to properly interact with it. The objects are fully **de-coupled** and instances of `Bear` and `Crab` **delegate** responsibility onto `Mobility`.

## Inheritance vs. Composition

The question of whether to use inheritance or composition typically depends on the situation. Both serve similar functions, but result in very different outcomes.

If you have a simple object hierarchy that answers yes to the question: "is *y* a kind of *x*?", you will likely first abstract the essence of *x* and create subclasses that inherit its behavior. Inheritance shines in simple examples that follow a disciplined path -- non-complex object relationships that build nicely off a defined superclass.

If the relationship is less hierarchical, however, reaching for composition is usually a good bet. Composition tends to provide more flexibility and extensibility, especially when attempting to model your code around a future which is largely unknown and in constant flux.
