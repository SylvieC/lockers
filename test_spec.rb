require './hotel.rb'
require './locker.rb'
require 'rspec'

  describe 'Hotel' do
   
   it 'creates the right amounts of lockers for small size' do
     hotel = Hotel.new('Las Vegas')
     hotel.install_lockers('small', 10)
     hotel.num_lockers_available('small').should eq(10)
    end

     it 'creates the right amounts of lockers for medium size' do
      hotel = Hotel.new('Las Vegas')
     hotel.install_lockers('medium', 15)
     hotel.num_lockers_available('medium').should eq(15)
    end

    it 'creates the right amounts of lockers for large size' do
      hotel = Hotel.new('Las Vegas')
     hotel.install_lockers('large', 12)
     hotel.num_lockers_available('large').should eq(12)
    end
    
    describe 'take_next_locker' do
      before(:each) do
        @hotel = Hotel.new('Vegas')
        @hotel.install_lockers('small', 5)
        @hotel.install_lockers('medium', 5)
        @hotel.install_lockers('large', 5)
     end

    it 'gives me locker the right size if there are still available lockers that size' do 
      number = @hotel.take_next_locker('medium')
      locker = @hotel.lockers.select { |locker| locker.number == number}.first
      locker.size.should eq ('medium')
    end
    it 'gives the appropriate number for locker'do
      @hotel.take_next_locker('medium')
      number = @hotel.take_next_locker('medium')
      locker = @hotel.lockers.select { |locker| locker.number == number}.first
      locker.number.should eq (7) 
    end  
    it 'when there are no more locker the size needed, it gives a locker on the next size' do
     for i in 0..5
        @hotel.take_next_locker('small')
     end
     number = @hotel.take_next_locker('small')
     locker = @hotel.lockers.select { |locker| locker.number == number}.first
     locker.size.should eq('medium')
     
   end

    it 'gives me the answer "no more locker for that size" when no locker can accomodate my size' do
      for i in 0..5
        @hotel.take_next_locker('large')
      end
      answer = @hotel.take_next_locker('large')
      answer.should eq('Sorry, no more lockers available for that size!')
    end
    it 'the available property of a locker becomes false when that locker is chosen' do
      number = @hotel.take_next_locker('medium')
      locker = @hotel.lockers.select { |locker| locker.number == number}.first
      locker.available.should eq(false)
    end
  end
    

     describe 'free_locker'do
        before(:each) do
        @hotel = Hotel.new('Vegas')
        @hotel.install_lockers('small', 5)
        @hotel.install_lockers('medium', 5)
        @hotel.install_lockers('large', 5)
        @hotel.take_next_locker('small')
        @hotel.take_next_locker('medium')
        @hotel.take_next_locker('large')
     end
      it 'frees the locker with the right number' do
        locker_num_5 = @hotel.lockers.select { |locker| locker.number == 5}.first
        locker_num_5.available = false
        expect {@hotel.free_locker(5)}.to change(locker_num_5, :available).from(false).to(true)
      end
      it 'if the number given corresponds to a locker already free, it displays the right message ' do
        locker_num_10 = @hotel.lockers.select {|locker| locker.number == 10}.first
        locker_num_10.available = true
        @hotel.free_locker(10).should eq(" Invalid entry. The locker number 10 was already free ")
      end
      it "if the locker number doesn't exist, it displays the right message" do
        @hotel.free_locker(35).should eq("We don't have any locker number 35 in the hotel")
      end
     end
  end

  describe Locker do
    it 'creates a locker with the name,size, and availibility given' do
     locker = Locker.new(1,'medium', true)
     locker.number.should eq(1)
     locker.size.should eq('medium')
     locker.available.should eq(true)
  end

end
 