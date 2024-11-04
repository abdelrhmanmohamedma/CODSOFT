import 'package:flutter/material.dart';
import 'package:to_do_list/main.dart';

final homeStateKey = GlobalKey<FormState>();
var titleController = TextEditingController();
var descriptionController = TextEditingController();
int IDCounter = 0;
List<int> selectedTasks = [];

DateTime selectedDate = DateTime.now();
TimeOfDay selectedTime = const TimeOfDay(hour: 12, minute: 00);

List<Task> tasks = [];
List<Task> todayTasks = getTodayTasks();


class Task {
  String title;
  String description;
  String date;
  TimeOfDay? time;
  String state;
  int id = 0;
  Task({required this.title, this.description = '' , this.date = '', this.time, this.state = 'active'}) {
    id = ++IDCounter;
  }
}

TabBar tabBar({required List<Widget> tabs, required TabController controller}) {
  return TabBar(
    controller: controller,
    tabs: tabs,
  );
}

TabBarView tabBarView({required List<Widget> views, required TabController controller}) {
  return TabBarView(
    controller: controller,
    children: views,
  );
}

void setDate(BuildContext context) async {
  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: selectedDate,
    firstDate: DateTime(2000),
    lastDate: DateTime(3000),
  );

  if(pickedDate != null) {
    selectedDate = pickedDate;
  }
}


void setTime(BuildContext context) async {
  TimeOfDay? pickedTime = await showTimePicker(
    context: context,
    initialTime: selectedTime,
  );

  if(pickedTime != null) {
    selectedTime = pickedTime;
    }
}



bool isTodayTask(Task task) {
  String date = DateTime.now().toString().split(' ')[0];
  String? taskDate = task.date;
  return date == taskDate;
}

List<Task> getTodayTasks() {
  if(tasks.isNotEmpty) {
    List<Task> temp = [];
    for(Task t in tasks) {
      isTodayTask(t) ? temp.add(t) : null;
    }
    return temp;
  }
  return [];
}


void customSort(List<Task> tasks) {
  if(tasks.isNotEmpty) {

    // sort by time
  tasks.sort((t1, t2) {
    if(t1.time!.hour < t2.time!.hour) {
      return -1;
    }
    else if(t1.time!.hour >= t2.time!.hour) {
      return 1;
    }
    else if(t1.time!.minute < t2.time!.minute) {
      return -1;
    }
    return 1;
  });

   // sort by period
    tasks.sort((t1, t2) {
    if(t1.time!.period.name == 'am' && t2.time!.period.name == 'pm') return -1;
    return 1;
  });

  List<String> d1, d2;
  // sort by day
  tasks.sort((t1, t2) {
      d1 = t1.date.split('-');
      d2 = t2.date.split('-');

      if(int.parse(d1[2]) < int.parse(d2[2])) return -1;
      return 1;
  });

  // sort by month
  tasks.sort((t1, t2) {
      d1 = t1.date.split('-');
      d2 = t2.date.split('-');

      if(int.parse(d1[1]) < int.parse(d2[1])) return -1;
      return 1;
  });


  }

    
    
    

  

   

  
}

AlertDialog dialog(BuildContext context, List<Widget> actions, [bool flag = true]) {
  String title = flag? 'Add New Task' : 'Update Task';
  return AlertDialog(
    title: Text(title),
    content: Column(
      mainAxisSize: MainAxisSize.values.first,
      children: [
        Form(
          key: homeStateKey,
          child: Column(
            children: [
              TextFormField(
          validator: (String? taskTitle) {
            if(titleController.text == '') {
              return 'title field cannot be empty';
            } return null;
            },
          controller: titleController,
          decoration: const InputDecoration(
            focusedBorder: OutlineInputBorder(),
            enabledBorder: UnderlineInputBorder(),
            label: Text('Task Title'),
          ),
        ),
        SizedBox(height: 10.0,),
        TextFormField(
          controller: descriptionController,
          decoration: const InputDecoration(
            focusedBorder: OutlineInputBorder(),
            enabledBorder: UnderlineInputBorder(),
            label: Text('Task Description'),
          ),
        ),
        SizedBox(height: 10.0,),
        Row(
          children: [
            IconButton(
            onPressed: () {
              setDate(context);
            },
            icon: Icon(Icons.date_range)
          ),
            IconButton(
              onPressed: () {
                setTime(context);
              },
              icon: Icon(Icons.timer)
            ),
          ],
        ),
            ],
          ),
        ),
      ],
    ),
    actions: actions,
  );
}

String getTomorrowDate() {
  List<String> date = DateTime.now().toString().split(' ')[0].split('-');
  int todYear = int.parse(date[0]);
  int todMonth = int.parse(date[1]);
  int todDay = int.parse(date[2]);

  int tomYear = int.parse(date[0]);
  int tomMonth = int.parse(date[1]);
  int tomDay = int.parse(date[2]);

  if(todDay == tomYear) {
    if(todMonth % 2 == 0) {
      if(todDay < 30) {
        tomDay = todDay+1;
      } else {
        tomDay = 1;
        if(todMonth >= 12) {
          tomMonth = 1;
        }
      }
    }
    else if(todMonth % 2 != 0) {
      if(todDay < 31) {
        tomDay = todDay+1;
      } else {
        tomDay = 1;
        if(todMonth >= 12) {
          tomMonth = 1;
          tomYear = todYear+1;
        }
      }
    }
  }

  return '$tomYear-$tomMonth-${tomDay+1}';
}

List<Task> getTomorrowTasks() {
  List<Task> tomTasks = [];
  if(tasks.isNotEmpty) {
    customSort(tasks);
      for(Task t in tasks) {
        if(t.date.compareTo(getTomorrowDate()) == 0) {
          tomTasks.add(t);
        }
      }
  }
  return tomTasks;
}

String parseDate(String date) {
  List<String> parsedDate = date.split('-');
  String resultDate = parsedDate[2];

  switch(parsedDate[1]) {
    case '1':
      resultDate += ' January';
      break;
    case '2':
      resultDate += ' February';
      break;
    case '3':
      resultDate += ' March';
      break;
    case '4':
      resultDate += ' April';
      break;
    case '5':
      resultDate += ' May';
      break;
    case '6':
      resultDate += ' Jone';
      break;
    case '7':
      resultDate += ' July';
      break;
    case '8':
      resultDate += ' August';
      break;
    case '9':
      resultDate += ' September';
      break;
    case '10':
      resultDate += ' October';
      break;
    case '11':
      resultDate += ' November';
      break;
    case '12':
      resultDate += ' December';
      break;
  }

  return resultDate;

}