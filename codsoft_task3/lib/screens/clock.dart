import "../commons/imports.dart";

class Clock extends StatefulWidget {
  ClockState createState() => ClockState();
}

class ClockState extends State<Clock> {
  String currentTime = "";
  String currentDate = "";

  void initState() {
    timer.cancel();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        currentTime = timeParsing();
        currentDate = dateParsing(DateTime.now());
      });
    });

    super.initState();
  }

  Widget build(BuildContext context) {
    return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children:[
              Text(
              currentTime,
              style: const TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.w300,
              ),
              ),
              Text(
              currentDate,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w200,
              ),
              ),
          ],
        ),
      );
  }

  String timeParsing() {
    String time = TimeOfDay.now().format(context);

    String hour = time.split(':')[0];
    String minutes = time.split(':')[1].split(' ')[0];
    String seconds = DateTime.now().toString().split(' ')[1].split(':').last.split('.')[0];
    String period = time.split(':')[1].split(' ')[1];

    return '$hour:$minutes:$seconds $period';
  }
  String dateParsing(DateTime t) {
    String date = t.toString().split(' ')[0];
    return date;
  }
}