import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:to_do_app/providers/task_type_provider.dart';

import '../models/taskTypeFilter/task_type_filter.dart';

class TaskTypeFilterList extends ConsumerWidget {
  const TaskTypeFilterList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<TaskTypeFilter> taskTypes = ref.watch(taskTypeListStateProvider);

    return SizedBox(
      height: 100.0,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 15.0, 8.0, 15.0),
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            final TaskTypeFilter typeFilter = taskTypes[index];
            return GestureDetector(
              onTap: () => ref
                  .read(taskTypeListStateProvider.notifier)
                  .changeApplied(typeFilter),
              child: Opacity(
                opacity: typeFilter.applied ? 1.0 : 0.5,
                child: Container(
                  width: 70.0,
                  height: 70.0,
                  margin: const EdgeInsets.only(right: 25.0),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(7.5),
                    ),
                    color: Colors.cyanAccent,
                    boxShadow: typeFilter.applied
                        ? <BoxShadow>[
                            const BoxShadow(
                                color: Colors.black26,
                                offset: Offset(8.0, 8.0),
                                blurRadius: 8.0)
                          ]
                        : <BoxShadow>[
                            const BoxShadow(
                                color: Colors.black12,
                                offset: Offset(4.0, 4.0),
                                blurRadius: 4.0)
                          ],
                  ),
                  child: Center(
                    child: Text(typeFilter.name
                        // typeFilter.name[0].toUpperCase(),
                        ),
                  ),
                ),
              ),
            );
          },
          itemCount: taskTypes.length,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }
}
