import 'package:hive_ce/hive.dart';
import 'package:injectable/injectable.dart';
import '../../../booking/domain/entities/booking_entity.dart';
import '../../../booking/domain/entities/booking_status.dart';
import '../../../booking/domain/repositories/booking_cache_contract.dart';
import '../models/available_time_slot_model.dart';
import '../models/booking_model.dart';

/// Local Hive-backed data source for booking and availability slot data.
///
/// Implements [BookingCacheContract] to allow cross-feature consumers to
/// access persisted booking data through a domain-level abstraction.
@lazySingleton
class BookingLocalDataSource implements BookingCacheContract {
  static const String _boxPrefix = 'booking_slots_box_';
  static const String _historyBoxName = 'booking_history_box';

  // ── Availability slot caching (booking-feature internal use) ──────────────

  /// Caches [slots] for the given [serviceId], replacing any prior entries.
  Future<void> cacheAvailableTimes(
    String serviceId,
    List<AvailableTimeSlotModel> slots,
  ) async {
    final box =
        await Hive.openBox<AvailableTimeSlotModel>('$_boxPrefix$serviceId');
    await box.clear();
    for (int i = 0; i < slots.length; i++) {
      await box.put(i, slots[i]);
    }
  }

  /// Returns cached availability slots for [serviceId], or an empty list.
  Future<List<AvailableTimeSlotModel>> getCachedAvailableTimes(
    String serviceId,
  ) async {
    final box =
        await Hive.openBox<AvailableTimeSlotModel>('$_boxPrefix$serviceId');
    return box.values.toList();
  }

  // ── BookingCacheContract implementation ───────────────────────────────────

  @override
  Future<void> cacheBooking(BookingEntity booking) async {
    final box = await Hive.openBox<BookingModel>(_historyBoxName);
    await box.add(_toModel(booking));
  }

  @override
  Future<List<BookingEntity>> getCachedBookings() async {
    final box = await Hive.openBox<BookingModel>(_historyBoxName);
    return box.values.map(_toEntity).toList();
  }

  @override
  Future<void> updateBookingStatus(String id, BookingStatus newStatus) async {
    final box = await Hive.openBox<BookingModel>(_historyBoxName);
    final entries = box.values.toList();
    for (int i = 0; i < entries.length; i++) {
      if (entries[i].id == id) {
        await box.putAt(
          i,
          BookingModel(
            id: entries[i].id,
            service: entries[i].service,
            date: entries[i].date,
            time: entries[i].time,
            notes: entries[i].notes,
            status: newStatus,
          ),
        );
        return;
      }
    }
  }

  // ── Private helpers ───────────────────────────────────────────────────────

  BookingModel _toModel(BookingEntity e) => BookingModel(
        id: e.id.isNotEmpty
            ? e.id
            : DateTime.now().millisecondsSinceEpoch.toString(),
        service: e.service,
        date: e.date,
        time: e.time,
        notes: e.notes,
        status: e.status,
      );

  BookingEntity _toEntity(BookingModel m) => BookingEntity(
        id: m.id,
        service: m.service,
        date: m.date,
        time: m.time,
        notes: m.notes,
        status: m.status,
      );
}
