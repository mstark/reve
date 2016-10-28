require 'test_helper'

class UpcomingCalendarEventsTest < Test::Unit::TestCase

  def setup
    @api = get_api
    assert_nil @api.last_hash
    FileUtils.mkdir(SAVE_PATH) rescue nil
  end

  def teardown
    FileUtils.rm_rf(SAVE_PATH)
  end

  def test_upcoming_calendar_events
    Reve::API.upcoming_calendar_events_url = XML_BASE + 'upcomeing_calendar_events.xml'
    events = nil
    assert_nothing_raised do
      events = @api.upcoming_calendar_events(:characterid => 1)
    end
    assert_equal 2, events.length
    assert_equal 2, events.first.owner_Type_ID
    assert_equal 60, events.first.duration
    assert_equal "foo_ownerName", events.first.owner_Name
    assert_equal "foo_eventTitle", events.first.event_Title
    assert_equal "0", events.first.importance
    assert_equal "foo_eventText", events.first.event_Text
    assert_equal "Undecided", events.first.response
    assert_equal "2013-09-03 11:13:34", events.first.event_Date.getgm.strftime('%Y-%m-%d %I:%M:%S')
  end

end
