class Mirror
  def echo
    print "enter something: "
    response = gets.chomp
    puts "#{response}"
  end
end
