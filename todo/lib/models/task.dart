import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  Task(
      {required this.id,
      required this.title,
      required this.subTitle,
      required this.createdTime,
      required this.createdDate,
      required this.isCompleted});

  @HiveField(0)
  final String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String subTitle;
  @HiveField(3)
  DateTime createdTime;
  @HiveField(4)
  DateTime createdDate;
  @HiveField(5)
  bool isCompleted;

  // create new Task
  factory Task.create({
    required String? title,
    required String? subTitle,
    DateTime? createdTime,
    DateTime? createdDate,
  }) =>
      Task(
        id: const Uuid().v1(),
        title: title ?? "",
        subTitle: subTitle ?? "",
        createdTime: createdTime ?? DateTime.now(),
        createdDate: createdDate ?? DateTime.now(),
        isCompleted: false,
      );
}
