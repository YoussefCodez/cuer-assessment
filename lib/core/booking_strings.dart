class BookingStrings {
  static const String bookingScreenTitle = 'Book Service';
  static const String bookingStepSelectTime = 'Select Time';
  static const String bookingStepNotes = 'Notes';
  static const String bookingStepConfirm = 'Confirm';

  static const String bookingAvailableDate = 'Select Available Date';
  static const String bookingAvailableTime = 'Select Available Time';
  static const String bookingSelectDayPrompt = 'Please select a day to view available times';
  static const String bookingContinue = 'Continue';

  // Step 2 - Notes
  static const String notesTitle = 'Medical Notes';
  static const String notesSubtitle = 'Share any important health information with the nurse';
  static const String notesHint = 'e.g. I have diabetes, allergic to penicillin, need wheelchair access...';
  static const String notesLabel = 'Health Notes (Optional)';
  static const String notesInfoTip = 'This information will be shared with your assigned nurse to ensure the best care.';

  // Step 3 - Summary
  static const String summaryTitle = 'Booking Summary';
  static const String summaryServiceLabel = 'Service';
  static const String summarySelectedDay = 'Day';
  static const String summarySelectedTime = 'Time';
  static const String summaryServiceCost = 'Service Cost';
  static const String summaryFeeCost = 'Service Fee';
  static const String summaryTotal = 'Total';
  static const String summaryNotes = 'Your Notes';
  static const String summaryNoNotes = 'No notes added';
  static const String confirmButton = 'Confirm Booking';
  static const String bookingSuccess = 'Booking confirmed successfully!';
  static const String bookingFailed = 'Booking failed. Please try again.';
  static const String summaryCurrencyLabel = 'EGP';

  /// Platform service fee added to every booking
  static const double serviceFee = 50.0;
}

