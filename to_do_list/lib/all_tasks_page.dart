import 'package:flutter/material.dart';
import 'main.dart';
import 'globals.dart';

class TasksPage extends StatefulWidget {
  TasksPageState createState() => TasksPageState();
}

class TasksPageState extends State<TasksPage> {

    Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {setState(() {});},
            icon: const Icon(Icons.refresh),
          ),
        ],
        centerTitle: true,
        title: const Text('All Tasks'),
      ),

      body: ListView(
        children: [
          Padding(
            padding:const EdgeInsets.all(10.0),
            child: Column(children: [...displayTasks(tasks, context)],)),
        ],
      ),

        floatingActionButton: FloatingActionButton(
          isExtended: true,
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return dialog(context, addTaskActions(context));
              }
            );
          },
          child: const Icon(Icons.add)
        ),
    );
  }

  List<Widget> displayTasks(List<Task> list, BuildContext context) {
  customSort(list);
  List<Widget> cards = [];
  if(list.isNotEmpty) {
    String currDate = '';
    bool update = true;
    for(Task t in list) {
      update = currDate.isEmpty || t.date != currDate? true : false;
      if(update) {
        currDate = t.date;
        update = false;
        cards.add(Text(parseDate(currDate), style: const TextStyle(fontSize: 15.0)));
        cards.add(const Divider());
      }
      cards.add(Card(
        color: Colors.grey[150],
        child: ListTile(
          title: Text(
            t.title,
            style: const TextStyle(
              fontSize: 23.0,
              fontWeight: FontWeight.w600),
              ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(color: Colors.grey,),
              Text('Description: ${t.description}'),
              Text('Start Time: ${t.time!.format(context)}'),
              Text('State: ${t.state}'),
            ],
          ),
          trailing: PopupMenuButton(
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                child: const Row(
                  children: [
                    Icon(Icons.update),
                    Text('Update')
                  ],
                ),
                onTap: () {
                  Task temp = tasks.firstWhere((task) => task.id == t.id);
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return dialog(context, updateTaskActions(temp), false);
                    }
                    );
                },
              ),
              PopupMenuItem(
                onTap: () {
                  tasks.removeWhere((task) => task.id == t.id);
                  todayTasks.removeWhere((task) => task.id == t.id);
                  setState((){});
                },
                child: const Row(
                  children: [
                    Icon(Icons.delete),
                    Text('Delete')
                  ],
                ),
              ),
              PopupMenuItem(
                onTap: () {
                  t.state = 'Completed';
                  setState((){});
                },
                child: const Row(children: [Icon(Icons.task_alt), Text('Mark Completed')],),
              ),
            ],
          ),
        ),    
      ));
    }
    return cards;
  }
  return [const Center(child: Text('No Tasks Found'))];
}

  List<Widget> addTaskActions(BuildContext context) {
  return [
      TextButton(
        onPressed: () {
          Task newTask = Task(
            title: titleController.text,
            description: descriptionController.text,
            date: selectedDate.toString().split(' ')[0],
            time: selectedTime,
          );
          titleController = TextEditingController();
          descriptionController = TextEditingController();

          if(!tasks.contains(newTask)) {
            tasks.add(newTask);
            if(isTodayTask(newTask)) {
              todayTasks.add(newTask);
            }
          }
          
          Navigator.pop(context);
          setState(() {});
          },
        child: const Text('Add'),
    ),
    TextButton(
        onPressed: () {Navigator.pop(context);},
          child: const Text('cancel'),
          )

    ];
}

  List<Widget> updateTaskActions(Task temp) {
    titleController.text = temp.title;
    descriptionController.text = temp.description;

    // date parsing
    List date = temp.date.split('-');
    int year = int.parse(date[0]);
    int month = int.parse(date[1]);
    int day = int.parse(date[2]);

    selectedDate = DateTime(year, month, day);
    selectedTime = temp.time as TimeOfDay;

    return [
      TextButton(
        onPressed: () {
          temp.title = titleController.text;
          temp.description = descriptionController.text;
          temp.date = '${year.toString()}-${month.toString()}-${day.toString()}';
          temp.time = selectedTime;

          titleController = TextEditingController();
          descriptionController = TextEditingController();

          Navigator.pop(context);
          
          setState(() {});
          },
        child: const Text('Update'),
    ),
    TextButton(
        onPressed: () {Navigator.pop(context);},
          child: const Text('cancel'),
          )
    ];
  }
}

