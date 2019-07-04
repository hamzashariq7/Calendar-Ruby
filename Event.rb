class Event
  attr_accessor :description
  attr_reader :id, :date

  @@curr_id = 0

  def self.curr_id
    @@curr_id
  end

  def self.increment_id
    @@curr_id += 1
  end

  private

  def initialize(description, date)
    @date = date.dup
    @description = description.dup
    @id = Event.curr_id
    Event.increment_id
  end

  public

  def print # change name to print
    puts "Event id: #{@id}, date: #{@date.day}/#{@date.month}/#{@date.year}"
    puts "description: #{@description}\n\n"
  end

  def ==(other)
    (date == other.date) && (description == other.description)
  end
end
