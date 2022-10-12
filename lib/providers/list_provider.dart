import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/task.dart';

final tasksListProvider = Provider((_) {
  return mockTaskList;
});
