public class EventScheduler {
  // Define the method to find free time slots
  @AuraEnabled(cacheable=true)
  public static List<EventWrapper> findFreeTimeSlots() {
    // Query the Business Hours Id for your specific business hours configuration

    BusinessHours businessHoursRecord = [
      SELECT Id, MondayStartTime, MondayEndTime
      FROM BusinessHours
      WHERE IsDefault = TRUE
    ];
    System.debug('businessHoursRecord: ' + businessHoursRecord);

    Id businessHoursId = businessHoursRecord.Id;
    // Define working hours
    Time workStartTime = businessHoursRecord.MondayStartTime;
    Time workEndTime = businessHoursRecord.MondayEndTime;

    List<Date> businessDates = new List<Date>();
    for (Integer i = 0; i < 5; i++) {
      // 5 business days
      Date d = System.today().addDays(i);
      DateTime dt = DateTime.newInstance(d, Time.newInstance(12, 0, 0, 0));
      System.debug(
        'BusinessHours.isWithin: ' + BusinessHours.isWithin(businessHoursId, dt)
      );
      if (BusinessHours.isWithin(businessHoursId, dt)) {
        businessDates.add(d);
        System.debug('businessDates in a loop: ' + businessDates);
      }
    }

    System.debug('businessDates: ' + businessDates);

    List<EventWrapper> freeSlotsTime = new List<EventWrapper>();
    // Query for events
    List<Event> events = [
      SELECT Id, Subject, StartDateTime, EndDateTime
      FROM Event
      WHERE
        StartDateTime >= :Datetime.newInstance(
          businessDates[0],
          Time.newInstance(0, 0, 0, 0)
        )
        AND StartDateTime < :Datetime.newInstance(
          businessDates[4],
          Time.newInstance(23, 59, 59, 0)
        )
      ORDER BY StartDateTime
    ];

    // Find available slots
    freeSlotsTime = getFreeTimeSlots(
      events,
      businessDates,
      workStartTime,
      workEndTime
    );

    return freeSlotsTime;
  }

  private static List<EventWrapper> getFreeTimeSlots(
    List<Event> events,
    List<Date> businessDates,
    Time workStartTime,
    Time workEndTime
  ) {
    List<EventWrapper> freeSlotsData = new List<EventWrapper>();

    for (Date businessDate : businessDates) {
      DateTime dateTimeValue = DateTime.newInstance(
        businessDate,
        workStartTime
      );
      while (dateTimeValue.time() < workEndTime) {
        DateTime endTime = dateTimeValue.addMinutes(60);
        if (!isEventWithinTime(events, dateTimeValue, endTime)) {
          EventWrapper eventWrapper = new EventWrapper();
          eventWrapper.startTime = dateTimeValue;
          eventWrapper.endTime = endTime;
          freeSlotsData.add(eventWrapper);
        }
        dateTimeValue = dateTimeValue.addMinutes(60);
      }
    }

    return freeSlotsData;
  }

  private static Boolean isEventWithinTime(
    List<Event> events,
    DateTime startTime,
    DateTime endTime
  ) {
    for (Event evt : events) {
      if (evt.StartDateTime <= startTime && evt.EndDateTime >= endTime) {
        return true;
      }
    }
    return false;
  }

  public class EventWrapper {
    @AuraEnabled
    public DateTime startTime;
    @AuraEnabled
    public DateTime endTime;
  }
}
