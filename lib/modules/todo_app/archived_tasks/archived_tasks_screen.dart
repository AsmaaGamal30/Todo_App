import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/shared/components/components.dart';
import 'package:todo/shared/components/cubit/cubit.dart';
import 'package:todo/shared/components/cubit/states.dart';


class ArchivedTasksScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit , AppStates>(
      listener: (BuildContext context , states) {},
      builder: (BuildContext context, state)
      {
        var tasks = AppCubit.get(context).archivedTasks;
        return tasksBuilder(
            tasks: tasks,
        );
      },
    );

  }
}
