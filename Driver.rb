require_relative 'Calendar'

class Driver
  def print_all_choices
    puts "1) Add an event"
    puts "2) Remove an event"
    puts "3) Edit an event"
    puts "4) Print a month"
    puts "5) Print details of events on a date"
    puts "6) Print details of events in a month"
    puts "7) exit"
  end

  def get_date
    print "Enter date(dd/mm/yyyy): "
    date = gets
    return false, [] if !(date =~ %r|\A\d{1,2}/\d{1,2}/\d{4}\Z|) 

    date = date.split('/')
    return true, date
  end

  def get_month
    print "Enter the month with the year(mm/yyyy): "
    date = gets
    return false, [] if !(date =~ %r|\A\d{1,2}/\d{4}\Z|) 

    date = date.split('/')
    return true, date
    #regex
  end

  def run
    my_calendar = Calendar.new
    exit_calendar = false

    print_all_choices

    while (!exit_calendar) do
      print "Enter your choice(8 to show all choices): "

      input = gets
      input.chomp!

      case input
      when '1' #add event
        valid, date = get_date

        if valid
          print "Enter event description: "
          description = gets
          description.chomp!

          my_calendar.add_event(description, date[0].to_i, date[1].to_i, date[2].to_i)
          puts "Event added successfully!"
        else
          puts "Invalid date entered!"
        end
      when '2'
        valid, date = get_date

        if valid
          print "Enter event id: "
          id = gets
          id = id.to_i

          if my_calendar.remove_event(id, date[0].to_i, date[1].to_i, date[2].to_i)
            puts "Event removed successfully!"
          else
            puts "The event with the given details does not exist!"
          end
        else
          puts "Invalid date entered!"
        end
      when '3'
        valid, date = get_date

        if valid
          print "Enter event id: "
          id = gets
          id = id.to_i

          print "Enter new description: "
          description = gets
          description.chomp!

          if my_calendar.edit_event(id, description, date[0].to_i, date[1].to_i, date[2].to_i)
            puts "Event edited successfully!"
          else
            puts "The event with the given details does not exist!"
          end
        else
          puts "Invalid date entered!"
        end
      when '4'
        valid, date = get_month

        if valid
          print "\n"
          my_calendar.print_month(date[0].to_i, date[1].to_i)
        else
          puts "Invalid date entered!"
        end
      when '5'
        valid, date = get_date

        if valid
          my_calendar.print_events_on_date(date[0].to_i, date[1].to_i, date[2].to_i)
        else
          puts "Invalid date entered!"
        end
      when '6'
        valid, date = get_month

        if valid
          my_calendar.print_events_on_month(date[0].to_i, date[1].to_i)
        else
          puts "Invalid date entered!"
        end
      when '7'
        exit_calendar = true
      when '8'
        print_all_choices
      else
        puts "Please enter a valid command."
      end

      print "\n"
    end
  end
end


Driver.new().run