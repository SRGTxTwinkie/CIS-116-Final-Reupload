class Main

  def initialize()
    @roomNumbers = []

    (1..300).each do |i|
      @roomNumbers.append(i)
    end

    @takenRooms = []
    @roomNames = []
    menu()
  end

  def menu
    puts "[1]: Room Description"
    puts "[2]: Check in"
    puts "[3]: Check out"
    puts "[4]: Display number of rooms available"
    puts "[5]: All taken rooms"
    puts "[6]: Export to .szi"
    puts "[7]: Exit"
    print "[Input]: "
    input = gets.chomp
    case input
    when "1"
      roomDescription()
    when "2"
      checkIn()
    when "3"
      checkOut()
    when "4"
      roomsAvailable()
    when "5"
      temp = @roomNames.zip(@takenRooms)
      temp.each do |tN,rN|
        print "#{tN} is in room number #{rN} \n"
      end
    when "6"
      txtOut()
    when "7"
      abort()
    else
      puts "Unknown option picked, please try again"
      menu()
    end
    menu()
  end

  def roomDescription

    print "Give me a name homie: "
    nameGiven = gets.chomp
    temp = @roomNames.zip(@takenRooms)
    temp.each do |tN, rN|
      if tN == nameGiven
        puts "#{tN} is in room number #{rN}"
        puts "It is a standard suite"
        break
      else
        puts tN
        next
      end
    end
    if @roomNames.length == 0
      puts "All rooms avalible"
    end
  end

  def checkOut()

    print "Who is checking out?: "
    name = gets.chomp
    temp = @roomNames.zip(@roomNumbers)
    temp.reverse.each do |tN,rN|
      case name
      when tN
        @roomNumbers.append(rN)
        @roomNames.delete_at(@roomNames.index(tN))
        @roomNumbers = @roomNumbers.sort()
        @roomNumbers.delete_at(0)
        break
      else
        next
      end
    end
  end

  def checkIn

    print "Please enter your name: "
    name = gets.chomp
    roomNumber = @roomNumbers[rand(1..@roomNumbers.count)]

    @roomNames.append(name)
    @takenRooms.append(roomNumber)

    puts "#{name} is in room number #{roomNumber}"

  end

 def roomsAvailable()

   puts "The rooms that are avalible are"
   @roomNumbers.each do |i|
     print i.to_s + ", "
   end
   puts

 end

 def txtOut
   print "Please enter your name: "
   name = gets.chomp
   File.new("#{name}_Info.szi", 'w')
   guestInfo = File.open("#{name}_Info.szi", 'w')
   temp = @roomNames.zip(@roomNumbers)
   temp.each do |tN, rN|
     if name == tN
       guestInfo.puts("#{tN} is in room number #{rN}")
       guestInfo.puts "They are in a standard suite"
       guestInfo.puts "They payed one chicken soul"
     end
   end
   guestInfo.close


 end

end

Main.new()
