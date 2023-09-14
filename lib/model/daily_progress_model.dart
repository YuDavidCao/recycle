import 'package:hive/hive.dart';

part 'daily_progress_model.g.dart';

@HiveType(typeId: 0)
class DailyProgressModel extends HiveObject {
  @HiveField(0)
  final DateTime? progressDateTime;

  @HiveField(1)
  final int totalCount;

  @HiveField(2)
  final int cardboardCount;

  @HiveField(3)
  final int glassCount;

  @HiveField(4)
  final int metalCount;

  @HiveField(5)
  final int paperCount;

  @HiveField(6)
  final int plasticCount;

  @HiveField(7)
  final int trash;

  DailyProgressModel({
    required this.progressDateTime,
    required this.totalCount,
    required this.cardboardCount,
    required this.glassCount,
    required this.metalCount,
    required this.paperCount,
    required this.plasticCount,
    required this.trash,
  });

  @override
  String toString() {
    return 'DailyProgressModel {'
        ' progressDateTime: $progressDateTime,'
        ' totalCount: $totalCount,'
        ' cardboardCount: $cardboardCount,'
        ' glassCount: $glassCount,'
        ' metalCount: $metalCount,'
        ' paperCount: $paperCount,'
        ' plasticCount: $plasticCount,'
        ' trash: $trash'
        '}';
  }
}
