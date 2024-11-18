import 'package:hive/hive.dart';
part 'stock.g.dart';

@HiveType(typeId: 0)
class Stock extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  double cmp;

  @HiveField(2)
  double yearHigh;

  @HiveField(3)
  double yearLow;

  @HiveField(4)
  double diiParticipation;

  @HiveField(5)
  double fiiParticipation;

  @HiveField(6)
  String notes;

  @HiveField(7)
  DateTime dateTime;

  Stock({
    required this.name,
    required this.cmp,
    required this.yearHigh,
    required this.yearLow,
    required this.diiParticipation,
    required this.fiiParticipation,
    required this.notes,
    required this.dateTime,
  });
}
