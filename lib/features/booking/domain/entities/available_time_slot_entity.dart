/// Domain entity representing an available appointment slot for a service.
///
/// Contains a day name and the list of available times for that day.
class AvailableTimeSlotEntity {
  /// Name of the day (e.g. "Monday").
  final String dayName;

  /// List of available time strings for [dayName] (e.g. ["09:00 AM", "02:00 PM"]).
  final List<String> times;

  const AvailableTimeSlotEntity({
    required this.dayName,
    required this.times,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AvailableTimeSlotEntity &&
          runtimeType == other.runtimeType &&
          dayName == other.dayName &&
          _listsEqual(times, other.times);

  @override
  int get hashCode => Object.hash(dayName, Object.hashAll(times));

  static bool _listsEqual(List<String> a, List<String> b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}
