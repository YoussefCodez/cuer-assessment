import 'package:hive_ce/hive.dart';
import 'package:injectable/injectable.dart';
import '../models/service_model.dart';

@lazySingleton
class HomeLocalDataSource {
  static const String _boxName = 'services_box';

  Future<void> cacheServices(List<ServiceModel> services) async {
    final box = await Hive.openBox<ServiceModel>(_boxName);
    await box.clear();
    for (final service in services) {
      await box.put(service.id, service);
    }
  }

  Future<List<ServiceModel>> getCachedServices() async {
    final box = await Hive.openBox<ServiceModel>(_boxName);
    return box.values.toList();
  }
}
