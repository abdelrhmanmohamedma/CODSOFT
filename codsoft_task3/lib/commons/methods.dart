import 'imports.dart';

String getAlarm(TimeOfDay current, BuildContext context) {
  List<String> temp;
  for(int i = 0; i < alarms.length; ++i) {
    temp = alarms[i].split('&');
    if(temp[3] == 'true' && temp[0].compareTo(current.format(context)) == 0) {
      temp[3] = 'false';
      alarms[i] = temp.join('&');
      return alarms[i];
    }
  }
  return "";
}

void updateAlarmState(int id, bool state) {
  List<String> temp;
  for(int i = 0; i < alarms.length; ++i) {
    temp = alarms[i].split('&');
    if(id == int.parse(temp[temp.length-1])) {
      temp[temp.length-2] = '$state';
      alarms[i] = temp.join('&');
    }
  }
}

bool getAlarmState(int id) {
  List<String> temp;
  for(String alarm in alarms) {
    temp = alarm.split('&');
    if(id == int.parse(temp[temp.length-1])) {
      // print(temp[temp.length-2]);
      return temp[temp.length-2] == 'true' ? true : false;
    }
  }
  return true;
}


