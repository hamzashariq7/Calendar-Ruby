require_relative 'Calendar'

class Driver
  private

  def print_all_choices
    puts '1) Add an event'
    puts '2) Remove an event'
    puts '3) Edit an event'
    puts '4) Print a month'
    puts '5) Print details of events on a date'
    puts '6) Print details of events in a month'
    puts '7) exit'
  end

  def gets_date
    print 'Enter date(dd/mm/yyyy): '
    date = gets
    if date !~ %r|\A\d{1,2}/\d{1,2}/\d{4}\Z|
      puts 'Please enter a valid date!'
      return false, []
    end

    date = date.split('/')
    begin
      date = Date.new(date[2].to_i, date[1].to_i, date[0].to_i)
    rescue ArgumentError
      puts 'Please enter a valid date!'
      return false, []
    end
    [true, date]
  end

  def gets_month
    print 'Enter the month with the year(mm/yyyy): '
    date = gets
    if date !~ %r|\A\d{1,2}/\d{4}\Z|
      puts 'Please enter a valid date!'
      return false, []
    end

    date = date.split('/')
    begin
      date = Date.new(date[1].to_i, date[0].to_i, 1)
    rescue ArgumentError
      puts 'Please enter a valid date!'
      return false, []
    end
    [true, date]
  end

  def gets_id
    print 'Enter event id: '
    id = gets
    if id !~ /\A\d+\Z/
      puts 'Please enter a valid id!'
      return -1
    end
    id.to_i
  end

  public

  def run
    my_calendar = Calendar.new
    exit_calendar = false

    print_all_choices

    until exit_calendar
      print "\nEnter your choice(8 to show all choices): "

      input = gets
      input.chomp!

      case input
      when '1' # add event
        valid, date = gets_date

        if valid
          print 'Enter event description: '
          description = gets
          description.chomp!

          my_calendar.add_event(description, date)
          puts 'Event added successfully!'
        end
      when '2'
        valid, date = gets_date
        next unless valid

        id = gets_id
        next if id < 0

        if my_calendar.remove_event(id, date)
          puts 'Event removed successfully!'
        else
          puts 'The event with the given details does not exist!'
        end
      when '3'
        valid, date = gets_date
        next unless valid

        id = gets_id
        next if id < 0

        print 'Enter new description: '
        description = gets
        description.chomp!

        if my_calendar.edit_event(id, description, date)
          puts 'Event edited successfully!'
        else
          puts 'The event with the given details does not exist!'
        end
      when '4'
        valid, date = gets_month

        if valid
          print "\n"
          my_calendar.print_month(date)
        end
      when '5'
        valid, date = gets_date
        my_calendar.print_events_on_date(date) if valid
      when '6'
        valid, date = gets_month
        my_calendar.print_events_on_month(date) if valid
      when '7'
        exit_calendar = true
      when '8'
        print_all_choices
      else
        puts 'Please enter a valid command.'
      end
    end
  end
end

Driver.new.run
