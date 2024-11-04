import "../commons/imports.dart";

class AddAlarm extends StatefulWidget {
  AddAlarmState createState() => AddAlarmState();
}

class AddAlarmState extends State<AddAlarm> {

  void initState() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {});
    });

    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            timer.cancel();
            Navigator.pop(context);
            },
          icon: const Icon(Icons.close),
        ),
        centerTitle: true,
        title: Text('Add Alarm'),
        actions: [
          IconButton(
          onPressed: () {
            timer.cancel();
            getAlarm(TimeOfDay.now(), context);
            if(alarmTime != '') {
              alarms.add('${alarmTime}&${alarmLabel}&${alarmDeleteOption}&${alarmState}&${++id}');
              alarmTime = '';
              alarmLabel = '';
              alarmDeleteOption = false;
              alarmState = true;
              selectedRadio = '';
            }

            Navigator.pop(context);
            },
          icon: const Icon(Icons.check),
        ),
        ]
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(40.0),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              onChanged: (String label) {
                setState(() {
                  alarmLabel = label;
                  
                });
              },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: UnderlineInputBorder(),
                  labelText: 'Label',
                ),
              ),
            ListTile(
              trailing:Icon(Icons.arrow_right),
              title: Text('Ringtone'),
              subtitle: Text(selectedRadio.toString()),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => CustomDialog());
              },
            ),
            ListTile(
              onTap: () {},
                leading: const Text(
                  'Vibrate when Alarm Sounds',
                  style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w600,
                  ) ,
                  ),
                trailing: Switch(
                  value: switchesValues[0],
                  onChanged: (bool value) {
                    setState(() {
                      switchesValues[0] = value;
                    });
                  },
                ),
              ),
            ElevatedButton(
              onPressed: () async {
                TimeOfDay? selectedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );

                if(alarmTime != null) {
                  alarmTime = selectedTime!.format(context);
                }
              },
              child: Text('Pick Time'),
              )
          ],
        )
        
        
        ),
      ),
    );
  }

}