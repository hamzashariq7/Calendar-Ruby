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

  def input_date
    print 'Enter date(dd/mm/yyyy): '
    date = gets
    if date !~ %r|\A\d{1,2}/\d{1,2}/\d{4}\Z|
      puts 'Please enter a valid date!'
      return nil
    end

    date = date.split('/')
    begin
      date = Date.new(date[2].to_i, date[1].to_i, date[0].to_i)
    rescue ArgumentError
      puts 'Please enter a valid date!'
      return nil
    end
    date
  end

  def input_month
    print 'Enter the month with the year(mm/yyyy): '
    date = gets
    if date !~ %r|\A\d{1,2}/\d{4}\Z|
      puts 'Please enter a valid date!'
      return nil
    end

    date = date.split('/')
    begin
      date = Date.new(date[1].to_i, date[0].to_i, 1)
    rescue ArgumentError
      puts 'Please enter a valid date!'
      return nil
    end
    date
  end

  def input_id
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
      input = gets.chomp! # can chain chomp

      case input
      when '1' # add event
        date = input_date # can return nil or date

        if date
          print 'Enter event description: '
          description = gets.chomp!

          my_calendar.add_event(description, date)
          puts 'Event added successfully!'
        end
      when '2'
        date = input_date
        next unless date

        id = input_id
        next if id < 0

        if my_calendar.remove_event(id, date)
          puts 'Event removed successfully!'
        else
          puts 'The event with the given details does not exist!'
        end
      when '3'
        valid, date = input_date
        next unless valid

        id = input_id
        next if id < 0

        print 'Enter new description: '
        description = gets.chomp!

        if my_calendar.edit_event(id, description, date)
          puts 'Event edited successfully!'
        else
          puts 'The event with the given details does not exist!'
        end
      when '4'
        date = input_month

        if date
          print "\n"
          my_calendar.print_month(date)
        end
      when '5'
        date = input_date
        if date
          unless my_calendar.print_events_on_date(date)
            puts 'No events found on this date!'
          end
        end
      when '6'
        date = input_month
        if date
          unless my_calendar.print_events_on_month(date)
              puts 'No events found in this month!'
          end
        end
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
