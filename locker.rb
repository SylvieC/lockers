class Locker
 attr_accessor :number, :size, :available

 def initialize(number, size, available)
  @number = number
  @size = size
  @available = available
 end

  def reverse_availability
    @available = !@available
  end

  def available?
    return @available === true
  end

end

