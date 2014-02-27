Observer Pattern
================

There may be scenarios in which you have an object that triggers the actions of third-party objects. The *Observer pattern* (sometimes referred to as *publish/subscribe*) is designed to effectively handle these types of circumstances in a manageable way.

Let's consider the following example:

###### When Tom turns on the shower, he would like:
- the coffee pot to brew coffee
- the tv to tune to a particular show
- his sonos sound system to play on some tunes

Semi-psuedo code for a situation like this **could** look like the following:

```ruby
class HomeOwner
  def initialize(name, fav_tv_station, fav_band, fav_coffee_type, coffeepot, television, sonos)
    @name = name
    @tv_station = tv_station
    ... # initialize rest of args as instance variables
  end

  def turn_on_shower
    @coffeepot.brew(@coffee_type)
    @television.tune(@tv_station)
    @sonos.shuffle(@fav_band)
  end
end

tom = HomeOwner.new('tom', 'sportscenter', 'Beatles, The', 'decaf', CoffeePot.new, Television.new, Sonos.new)
tom.turn_on_shower
```

Simple right? All the desired objects are triggered when `Homeowner#turn_on_shower` is invoked...

Well, not so fast...there is a much better way in keeping everything informed. The *Observer Pattern* is here to help.

### De-couple Observers from the Subject

In the above example, `HomeOwner` is our **subject**. It provides the stimulus or action which triggers other objects to react. These reactionary objects are the **observers** in the equation. The **subject** publishes an update, and the **observers** listen and spring into action when they hear the trigger.

Our first order of business is to separate out the **observers** from the `turn_on_shower` method. We'll keep them in an array that's instantiated (empty by default) when we create the **subject**. Below is our refactored `initialize` method:

```ruby
# home_owner.rb
...

def initialize(name, fav_tv_station, fav_band, fav_coffee_type)
  # Initialize instance variables as usual
  ...
  # Initialize an empty array to hold observers
  @observers = []
end
```

In addition to providing an array to store the **observers**, we'll have to add a few more utility methods to add/remove/call them.

```ruby
# home_owner.rb
...

# Add/Remove observers

def add_observers(observers)
  observers.each do |observer|
    @observers << observer
  end
end

def delete_observer(observer)
  @observers.delete(observer)
end

# Update trigger method

def turn_on_shower
  notify_observers
end

# Define the execution

def notify_observers
  @observers.each do |observer|
    observer.fire(self)
  end
end
```

Now, any `HomeOwner` can register observers like so:

```ruby
# Define HomeOwner and their interests
tom = HomeOwner.new('tom', 'sportscenter', 'Beatles, The', 'decaf')
mary = HomeOwner.new('mary', 'news', 'Coldplay', nil)

# Initialize observers
coffeepot, television, sonos = CoffeePot.new, Television.new, Sonos.new

# Add observers
tom.add_observers([coffeepot, television, sonos])
mary.add_observers([television, sonos])
```

This technique decouples **observers** from their respective **subject**, affording us the ability to define multiple `HomeOwner` instances, each with their own set of observers. We may define many, few, or even no observers and it won't matter one bit.

### Observer Interface

You may have noticed in our `noftify_observers` method that we call each **observer** with a `fire` call and pass in an instance of `self`. We can call this method anything, I chose `fire`, but it's important to remember that each **observer** will need to respond to this method. So, for example, the `CoffeePot` class could look like the following:

```ruby
class CoffeePot
  def fire(homeowner)
    brew homeowner.fav_coffee_type
  end

  def brew(coffee)
    # instructions for brewing coffee
  end
end
```

### Extract Observable into Module

Now that we have comprised a solid observable pattern, we can go ahead and wrap it up in a module so we can mix it in to any future **subject**. In fact, Ruby has already done this for us with its [Observable Module](http://ruby-doc.org/stdlib-1.9.3/libdoc/observer/rdoc/Observable.html#method-i-delete_observers) which works very similar to what we have explained above. In order to use the module, we would do something like:

```ruby
require 'observer'

class HomeOwner
  # Declare HomeOwner as a subject, providing
  # core observability functionality
  include Observable

  ...
  # rest of class implementation
end

class CoffeePot
  def update
    # all observers called by their update method
  end
end
...
```

The *Observer pattern* is nice way to keep **observer(s)** and their **subject** from tangling up. It is important to keep in mind the interface between the two and the level of complexity that should exist.
