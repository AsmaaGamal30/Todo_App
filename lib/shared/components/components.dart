import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'cubit/cubit.dart';



Widget defaultFormField ({
  required TextEditingController controller,
  required TextInputType type,
  bool isPssword = false,
  ValueChanged<String>? onSubmit,
  ValueChanged<String>? onChange,
  GestureTapCallback? onTap,
  bool isClickable = true,
  required  FormFieldValidator<String>? validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  VoidCallback? suffixPressed,


}) => TextFormField(
  controller: controller,
  keyboardType: type,
  obscureText: isPssword,
  onFieldSubmitted: onSubmit ,

  onChanged: onChange ,
  onTap: onTap,
  enabled: isClickable,
  validator: validate,
  decoration: InputDecoration(
    labelText: label ,
    prefixIcon:Icon(
      prefix,
    ),
    suffixIcon: IconButton(
      onPressed :suffixPressed,
      icon: Icon(
        suffix
      ),
    ),
  ),
);


Widget buildTaskItem (Map model ,context) => Dismissible(
  key: Key(model['id'].toString()),
  child:   Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40.0,
              child: Text(
                '${model['time']}',
              ),
              backgroundColor: Colors.blueAccent,
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model['title']}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  Text(
                    '${model['date']}',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 20,
            ),
            IconButton(
                icon: Icon(
                  Icons.check_box,
                  color: Colors.green,
                ),
              onPressed: ()
              {
                AppCubit.get(context).updateDatabase(
                  status: 'done',
                  id: model['id'],
                );
              },

            ),
            IconButton(
              icon: Icon(
                Icons.archive,
                color: Colors.black45,
              ),
              onPressed: ()
              {
                AppCubit.get(context).updateDatabase(
                  status: 'archived',
                  id: model['id'],
                );

              },

            ),


          ],
        ),
      ),
  onDismissed: (direction)
  {
    AppCubit.get(context).deleteDatabase(id: model['id'],);
  },
);

Widget tasksBuilder({
  required List<Map> tasks
}) => BuildCondition(
  condition: tasks.length>0,
  builder: (context) => ListView.separated(itemBuilder: (context ,index) => buildTaskItem(tasks[index],context),
    separatorBuilder: (context ,index) => myDivider() ,
    itemCount: tasks.length,
  ),
  fallback: (context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.menu,
          color: Colors.grey,
          size: 100.0,
        ),
        Text(
          'No Tasks Yet , Please Add Some Tasks',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ],
    ),
  ),

);


Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    height: 1.0,
    color: Colors.grey[300],
    width: double.infinity,
  ),
);



