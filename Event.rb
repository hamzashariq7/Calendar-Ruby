class Event

  attr_accessor :description
  attr_reader :id, :date

  @@curr_id = 0

  def initialize(description, date)
    @date = date.dup
    @description = description.dup
    @id = Event.curr_id
    Event.increment_id
  end

  def self.curr_id
    @@curr_id
  end

  def self.increment_id
    @@curr_id += 1
  end

  def print_event
    puts "Event id: #{@id}, date: #{@date.day}/#{@date.month}/#{@date.year}"
    puts "description: #{@description}\n\n"
  end

  def ==(other)
    return (self.date == other.date) && (self.description == other.description)
  end

  end

  #date = DateTime.new(2019, 1, 1)
  #x = Event.new("description asjfd", date)
  #puts x


