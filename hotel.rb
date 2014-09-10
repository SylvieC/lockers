class Hotel
  attr_accessor :name, :lockers

  def initialize(name)
    @name = name
    @lockers = []
  end  

  #method that builds lockers for a hotel 
  def install_lockers(size, number_of_lockers)
    last_number = @lockers.length
    start = last_number + 1
    stop = last_number + number_of_lockers 
    for i in start..stop
      @lockers.push(Locker.new(i, size, true))
    end
  end


  # method that returns the number of lockers available for a certain size
  def num_lockers_available(size)
    sum = 0
    @lockers.map do |locker| 
      if  locker.size === size && locker.available?
        sum += 1
      end
    end
    return sum
  end
  
  # This method returns true if there are lockers still available for the size given as an argument, false if not
  def any_locker_free?(size)
    if num_lockers_available(size) > 0
      return true
    else
      return false
    end
  end

def next_size(size)
  if size === 'small'
    return 'medium'
  elsif size === 'medium'
    return 'large'
  else
    return -1
  end
end

#returns a locker in the size needed if available in the size. If none are available exactly that size, it
# it returns a locker available in the next larger size. If none are available, it returns nil
 def next_available_locker(size)
  # if there are free lockers in the size needed, return the first available when itirating over array
  if any_locker_free?(size)
    @lockers.map do |locker|
      if locker.size === size && locker.available?
        return locker
      end 
    end 
  # if there are no locker in the size, we repeat the process with the next size if there is a next size
  # if there is no next size, we return -1
  else
    if next_size(size) != - 1
      return next_available_locker(next_size(size))
    else
      return nil 
    end
    
  end
end

 #this method gives the number of the next locker available and changes that locker's available property to false
 # if none are available it returns a message
 def take_next_locker(size)
     locker  = next_available_locker(size)
   if locker.nil?
     return 'Sorry, no more lockers available for that size!'
   else
     locker.reverse_availability
     return locker.number
   end
 end

# when given a number, this method changes the property available to true for the locker corresponding to that number
# it also catches input errors 
 def free_locker (number)
   @lockers.map do |locker|
    if locker.number === number
      if locker.available === false
        locker.reverse_availability
        return "The locker number #{number} is now available"
      else
        return " Invalid entry. The locker number #{number} was already free "
      end
    end
   end
   # if the number is not found after iterating through @lockers' numbers
   return "No locker in this hotel corresponding to the number entered"
 end

 def display_num_lockers_available
   small = self.num_lockers_available('small')
   medium = self.num_lockers_available('medium')
   large = self.num_lockers_available('large')
  if small + medium + large == 0
    puts "No more lockers available at present"
  else
   puts  "~Lockers available:  Small: #{small}, Medium: #{medium}, Large:  #{large} "
  end
 end

 def menu (message)
  puts "*** Lockers' Manager #{@name} *** "
  puts "#{message}\n\n" unless message.empty?
  puts '1 : Get a locker number'
  puts '2 : Free a locker'
  puts "q : Quit\n\n"
  print '--> '
  gets.chomp
end


end

 

 
