class A
  def hello; puts "hello"; end
  def goodbye; puts "goodbye"; end
end

class B < A
  def yo; puts "yo"; end
end

A.new.hello
B.new.hello
B.new.yo
A.new.yo
