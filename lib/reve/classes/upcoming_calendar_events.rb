module Reve #:nodoc
  module Classes #:nodoc

    #upcoming calendar events
    class UpcomingCalendarEvents
     attr_reader :id, :name, :owner_ID, :owner_Name, :event_Date, :event_Title, :duration, :importance, :response, :event_Text, :owner_Type_ID
     def initialize(elem) #:nodoc:
        @id = elem['eventID'].to_i
        @owner_ID = elem['ownerID'].to_i
        @owner_Name = elem['ownerName']
        @event_Date = elem['eventDate'].to_time
        @event_Title = elem['eventTitle']
        @duration = elem['duration'].to_i
        @importance = elem['importance']
        @response = elem['response']
        @event_Text = elem['eventText']
        @owner_Type_ID = elem['ownerTypeID'].to_i
      end
    end

  end
end
