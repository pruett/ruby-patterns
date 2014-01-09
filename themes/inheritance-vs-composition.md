### Inheritance

Inheritance is a core foundation upon which object oriented code is built upon. It generally describes a *is a kind of* relationship.

Consider the following code:

```ruby
class A
  def hello; puts "hello"; end
  def goodbye; puts "goodbye"; end
end

class B < A
  def yo; puts "yo"; end
end

A.new.hello => "hello"
B.new.hello => "hello"
B.new.goodbye => "goodbye"
B.new.yo => "yo"
A.new.yo => undefined method `yo'
```

Above we are declaring two class objects, `A` and `B`. We define `B` a bit differently, appending the first line of the class definition with `< A`. This is an inheritance declaration, allowing `B` to *inherit* all the behavior of `A` with no additional effort.

While inheritance shines in its ability to extend objects effortlessly, maintain code hierarchy, and keep code *DRY*, it falters, like anything, when used inappropriately. The **subclass** `B` becomes tightly coupled to its **superclass** `A`.

Over time, it's likely that `A`'s behavior will evolve. This will affect **any and all** subclasses of `A` (since it can have more than just one), possibly breaking previous functionality. This is where inheritance starts to decay.

Introducing Composition...

### Composition

Composition is a slightly different strategy used in structuring code. Composition typically illustrates a *has a* relationship between objects.

Consider the code below:

```ruby
class Functions
  def method; #something; end
  def method2; #something; end
end

class
```

Composition offers an alternative to the inheritance pattern. Composition aims at solving the pitfalls of inheritance with encapsualtion and de-coupling. Instead of the tightly coupled objects sometimes created as a result inheritance, composition allows us to keep objects independent of each other, without fear of indirectly affecting


## Inheritance Versus Composition
