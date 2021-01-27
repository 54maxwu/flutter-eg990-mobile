import 'package:flutter_eg990_mobile/utils/datetime_format.dart';
import 'package:hive/hive.dart';

part 'hive_json_cache.g.dart';

@HiveType(typeId: 90)
class HiveJsonCache extends HiveObject {
  @HiveField(0)
  DateTime lastUpdate;
  @HiveField(2)
  int expiredInHours;
  @HiveField(3)
  Map<String, dynamic> cacheMap;
  @HiveField(4)
  List cacheList;

  bool hasData;

  HiveJsonCache({
    this.expiredInHours = 2,
    this.cacheMap,
    this.cacheList,
    this.hasData = true,
  }) : assert((hasData && (cacheMap != null || cacheList != null)) || !hasData,
            'No data to cache!!');

  @override
  Future<void> save() {
    lastUpdate = DateTime.now();
    return super.save();
  }

  bool get hasExpired => lastUpdate.isAfterHours(expiredInHours);
}
