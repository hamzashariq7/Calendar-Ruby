require 'date'
require_relative 'Event'

class Calendar
  attr_accessor :events

  def initialize
    @events = {}
  end

  public

  def add_event(description, date)
    if @events.key?(date)
      @events[date] << Event.new(description, date)
    else
      @events[date] = [Event.new(description, date)]
    end
  end

  def get_events_by_date(date)
    ret_events = []
    ret_events = @events[date] if @events.key?(date)
    ret_events
  end

  def remove_event(event_id, date)
    ret = false

    unless @events[date].nil?
      ret = @events[date].reject! { |event| event.id == event_id }
    end

    if ret
      return true
    else
      return false
    end
  end

  def edit_event(event_id, description, date)
    unless @events[date].nil?
      @events[date].each do |event|
        if event.id == event_id
          event.description = description
          return true
        end
      end
    end

    false
  end

  def get_eventcount_by_date(date)
    get_events_by_date(date).length
  end

  def get_eventcount_by_month(date)
    end_date = Date.new(date.year, date.month, -1)
    date.upto(end_date).inject(0) { |sum, curr_date| sum + get_eventcount_by_date(curr_date) }
  end

  def print_events_on_date(date)
    return false if get_eventcount_by_date(date) == 0
    print "\n"
    print_events(get_events_by_date(date))
    true
  end

  # return false if no events found
  def print_events_on_month(start_date)
    return false if get_eventcount_by_month(start_date) == 0
    end_date = Date.new(start_date.year, start_date.month, -1)
    print "\n"
    start_date.upto(end_date).each { |date| print_events(get_events_by_date(date)) }
    true
  end

  def print_month_header(space_length)
    print "SUN#{' '*space_length}"
    print "MON#{' '*space_length}"
    print "TUE#{' '*space_length}"
    print "WED#{' '*space_length}"
    print "THU#{' '*space_length}"
    print "FRI#{' '*space_length}"
    puts "SAT#{' '*space_length}"
  end

  def print_month(start_date)
    end_date = Date.new(start_date.year, start_date.month, -1)
    events_in_month = get_eventcount_by_month(start_date)
    day_length = 5 + events_in_month.to_s.length
    space_length = day_length - 3

    print_month_header(space_length)
    print ' ' * (day_length * start_date.wday)

    start_date.upto(end_date).each do |date|
      print_string = date.day.to_s
      event_count = get_eventcount_by_date(date)
      print_string = "#{print_string}(#{event_count})" if event_count > 0
      print_string += ' ' * (day_length - print_string.length)
      print print_string

      print "\n" if date.wday % 7 == 6
    end

    print "\n"
  end

  private

  def print_events(events)
    events.each(&:print)
  end
end
