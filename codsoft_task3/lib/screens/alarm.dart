import "../commons/imports.dart";

class Alarm extends StatefulWidget {
  AlarmState createState() => AlarmState();
}

class AlarmState extends State<Alarm> {

  void initState() {
    timer.cancel();
    timer = Timer.periodic(Duration(milliseconds: 30), (Timer t) {setState((){});});

    super.initState();
  }
  Widget build(BuildContext context) {
    return Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [...displayAlarms()],
            ),
      );
  }

  List<Widget> displayAlarms() {
  List<Widget> alarmsWidgets = [];
  for(String alarm in alarms) {
    List<String> temp = alarm.split('&');

    alarmsWidgets.add(
      Card(
        child: ListTile(
          trailing: Switch(
            value: getAlarmState(int.parse(temp[4])),
            onChanged: (bool value) {
              setState(() {
                updateAlarmState(int.parse(temp[4]), value);
              });
              
            }
            ),
          title: Row(
            children: [
              Text(
                '${temp[0].split(' ')[0]} ',
                style: const TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w400,
                ),
                ),
              Text(
                temp[0].split(' ')[1],
                style: const TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                ),
                )
            ],
          ),
          subtitle: Text(temp[1]),
        ),
      )
    );
  }

  return alarmsWidgets;

}



}