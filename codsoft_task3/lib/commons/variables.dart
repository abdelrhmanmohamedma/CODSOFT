import 'imports.dart';

String pageTitle = "";
int selectedDestination = 0;
List<bool> switchesValues = [true, false];
String alarmLabel = "";
String alarmTime = "";
bool alarmDeleteOption = false;
bool alarmState = true;
List<String> alarms = [];
Timer timer = Timer(Duration(seconds: 0), (){});
Timer snoozeTimer = Timer(Duration(seconds: 0), (){});
int id = 0;
String triggeredAlarm = "";
int duration = 1;
String? selectedRadio = '';