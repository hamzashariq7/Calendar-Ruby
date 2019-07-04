require_relative 'Calendar'

describe Calendar do
  let(:calendar) { Calendar.new }

  context 'with valid input' do
    before(:each) do
      @date = Date.new
      @event = Event.new('Go to work', @date)
    end

    it 'should add the given event at the correct date' do
      event_array = calendar.add_event(@event.description, @date) # use return value of this method for testing
      expect(event_array[0]).to eq @event
    end

    it 'should remove an event given its id and date' do
      calendar.add_event(@event.description, @date)
      event_id = calendar.get_events_by_date(@event.date)[0].id
      expect(calendar.remove_event(event_id, @date)).to be true
    end

    it 'should edit the description of an event already added' do
      calendar.add_event(@event.description, @date)
      new_desc = 'Go to university'
      event_id = calendar.get_events_by_date(@event.date)[0].id
      calendar.edit_event(event_id, new_desc, @date)
      expect(calendar.get_events_by_date(@event.date)[0].description).to eq new_desc
    end

    it 'should be able to add multiple events on the same date' do
      calendar.add_event(@event.description, @date)
      calendar.add_event('Go to university', @date)
      event_array = calendar.add_event('Lunch at KFC', @date)
      expect(event_array.length).to eq 3
    end

    it 'should return an empty array if no events are found on the given date' do
      ret_value = calendar.get_events_by_date(Date.new(1990, 1, 1))
      expect(ret_value).to eq []
    end
  end
end
