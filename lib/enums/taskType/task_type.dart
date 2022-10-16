import 'package:hive/hive.dart';

part 'task_type.g.dart';

@HiveType(typeId: 1)
enum TaskType {
  @HiveField(0)
  home,
  @HiveField(1)
  work,
  @HiveField(2)
  shopping
}
