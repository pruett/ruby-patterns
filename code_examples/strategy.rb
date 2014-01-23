# class Hair
#   attr_reader :color, :texture, :length

#   def initialize(product)
#     @color = "brown"
#     @texture = "wavy"
#     @length = "short"
#     @product = product
#   end

#   def apply
#     @product.apply(self)
#   end
# end

# class Shampoo
#   def apply(context)
#     puts "washing the #{context.color}, #{context.texture} hair...}"
#   end
# end

# class Conditioner
#   def apply(context)
#     product = determine_conditioner(context)
#     puts "since this hair is #{context.length}, we'll have to use #{product}"
#   end

#   def determine_conditioner(context)
#     context.length == "short" ? "Brand A" : "Brand B"
#   end
# end

# hair = Hair.new(Shampoo.new)
# hair.apply

# hair = Hair.new(Conditioner.new)
# hair.apply

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
