require './hotel'
require './locker'
require 'pry'


hotel = Hotel.new("Las Vegas Hotel")
hotel.install_lockers('small', 3)
hotel.install_lockers('medium', 3)
hotel.install_lockers('large', 3)

def menu (message)
  puts "*** Lockers' Manager*** "
  puts "#{message}\n\n" unless message.empty?
  puts '1 : Get a locker number'
  puts '2 : Free a locker'
  puts "q : Quit\n\n"
  print '--> '
  str = gets
  exit if str.nil? or str.empty?
  str.chomp!
end

message = ""
choice = menu(message)
while choice != 'q'

 case choice
  when "1"
    #Get a locker
    # Get the size of the bag
    puts "What it the size of the bag? (S, M or L)"
    size_chosen = gets.chomp
    size_equivalent = { "S" => 'small', "s" => 'small', "M" => 'medium', "m" => 'medium', "L"  => 'large', "l" => 'large'}
    while size_equivalent[size_chosen].nil?
      puts "Please enter a valid size : S for small, M for medium, L for large"
      size_equivalent = gets.chomp
    end
      size = size_equivalent[size_chosen]
      # if a locker is available, print its number. If none are available, the message 'Sorry, no more lockers available for that size!'
      locker = hotel.next_available_locker(size)
      answer = hotel.take_next_locker(size)
      puts answer
     if answer.is_a? Numeric
       puts 'Printing ticket for locker number ' + answer.to_s + ' ...' 
       #method to trigger the printing machine
       message =   "Locker number #{answer} (size #{locker.size}) is now taken"
       hotel.display_num_lockers_available()
    end
     
  when "2"
    #Free a locker
    #ask for the number that needs to be freed
   puts " Enter the number of the locker to be freed"
   number = gets.chomp.to_i
   # free the locker with the number given if it was taken, if not signal the error
   puts hotel.free_locker(number)

  else
      message = "Invalid entry ... The options are 1, 2 or q"
  end
  choice = menu message
end
