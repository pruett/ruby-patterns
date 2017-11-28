Strategy Pattern
================

The *Strategy pattern* provides similar utility as the [Template Method pattern](/patterns/template_method.md), but instead chooses a [composition](/concepts/inheritance-vs-composition.md#composition)-based approach.

We'll continue where we left off with the [Template Method pattern](/patterns/template_method.md) example, but now, instead of creating `Shampoo` and `Conditioner` as subclasses, we'll define them as **strategies**.

```ruby
class Shampoo
  def apply(context)
    puts "washing the #{context.color}, #{context.texture} hair..."
  end
end

class Conditioner
  def apply(context)
    product = determine_conditioner(context)
    puts "since this hair is #{context.length}, we'll have to use #{product}"
  end

  def determine_conditioner(context)
    context.length == "short" ? "Brand A" : "Brand B"
  end
end
```

What makes these POROs (Plain Old Ruby Object) **strategies**? Well, nothing *yet*. You'll notice that they do share a common `apply` method and that each has their own unique execution. For now, the details of their execution are not of interest as we still have one more piece to define.

In addition to individual strategies, the *Strategy pattern* relies what's called a **context** object -- an object that uses strategies.

Let's define one now.

```ruby
class Hair
  attr_reader :color, :texture, :length

  def initialize(product)
    @color = "brown"
    @texture = "wavy"
    @length = "short"
    @product = product
  end

  def apply
    @product.apply(self)
  end
end
```

We define a `Hair` object which will serve as our **context**. It defines a few instance variables and accepts an argument upon initialization. This argument is the **strategy** being passed through to the **context**. Lastly, you'll see that the context object has an `apply` method of its own, which simply delegates the same call the newly instantiated strategy.

This is the *Strategy pattern* at work!

There are a few subtleties in our execution. Namely, when `Hair` delegates the `apply` method to its strategy, it passes an instance of itself along for the strategy to use at will. This is a nice technique that allows the strategy to use it's context as it sees fit, without explicitly having to set the arguments that are passed through.

Here is the result of our pattern in use:

```ruby
shampoo = Hair.new(Shampoo.new)
shampoo.apply #=> washing the brown, wavy hair...

conditioner = Hair.new(Conditioner.new)
conditioner.apply #=> since this hair is short, we'll have to use Brand A
```

The flexibility of this pattern is showcased if we choose to define our encapsulated strategies, not as classes, but as `Proc` objects instead.

```ruby
class Hair
  attr_reader :color, :texture, :length

  def initialize(&block) # accepts a code block
    @color = "brown"
    @texture = "wavy"
    @length = "short"
    @block = block
  end

  def apply
    @block.call(self) # calls code block with reference to itself
  end
end

shampoo = Hair.new { |context| puts "washing #{context.color} hair..." }
shampoo.apply #=> washing brown hair...

conditioner = Hair.new do |context|
  puts "since this hair is #{context.length},"
  puts "we'll have to use"
  puts "#{context.length == "short" ? "Brand A" : "Brand B"}"
end
conditioner.apply #=> since this hair is short, \n we'll have to use \n Brand A
```

By allowing our context to accept code blocks, we can quickly whip up new strategies at runtime without needing to define any additional class objects. Pretty sweet!

As you can see the *Strategy pattern* maintains a nice separation of concern between the **context** and **strategy** object(s). Since the **context** has no knowledge of how a **strategy** is implemented, the pattern imposes *nearly* no restrictions.

When implementing the *Strategy pattern* it is important to keep in mind how interfaces play a role. In our example, it was the `apply` method that was critical in making the **context** and **strategy** object(s) communicate. This delegation tradeoff is often a small price to pay compared to a tightly coupled inheritance-based implementation, however.
