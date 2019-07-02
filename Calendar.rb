require 'date'
require_relative 'Event'

class Calendar

	attr_accessor :events

	def initialize
		@events = Hash.new
	end

	def add_event(description, day=1, month=1, year=2019)
		date = Date.new(year, month, day)

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

	def remove_event(event_id, day=1, month=1, year=2019)
		date = Date.new(year, month, day)
		ret = false

		if @events[date] != nil
			ret = @events[date].reject! {|event| event.id == event_id}
		end

		if ret
			return true
		else
			return false
		end
	end

	def edit_event(event_id, description, day=1, month=1, year=2019)
		date = Date.new(year, month, day)

		if @events[date] != nil
			@events[date].each do |event|
				if event.id == event_id
					event.description = description
					return true
				end
			end
		end

		return false
	end

	def get_eventcount_by_date(date)
		get_events_by_date(date).length #correct approach?
	end

	def print_events(events)
		events.each {|event| event.print_event}
	end

	public

	def print_events_on_date(day=1, month=1, year=2019)
		date = Date.new(year, month, day)
		print "\n"
		print_events(get_events_by_date(date))
	end
	
	#return false if no events found
	def print_events_on_month(month, year=2019)
			print_string = date.day.to_s
		start_date = Date.new(year, month, 1)
		end_date = Date.new(year, month, -1)
		print "\n"
		start_date.upto(end_date).each {|date| print_events(get_events_by_date(date))}
	end

	def print_month(month, year=2019)
		start_date = Date.new(year, month, 1)
		end_date = Date.new(year, month, -1)

		day_length = 6

		puts "SUN   MON   TUE   WED   THU   FRI   SAT"
		print " "*(day_length * start_date.wday)

		start_date.upto(end_date).each do |date|
			print_string = date.day.to_s
			event_count = get_eventcount_by_date(date)
			print_string = "#{print_string}(#{event_count})" if event_count > 0
			print_string = print_string + (" " * (day_length - print_string.length()))
			print print_string

			print "\n" if date.wday % 7 == 6
		end

		print "\n"
	end

end