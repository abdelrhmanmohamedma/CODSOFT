import "commons/imports.dart";


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  NotificationSystem.notificationPlugin();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int selectedDestination = 0;
  String temp = '';
  void initState() {
    pageTitle = 'Clock';
    selectedDestination = 0;
    // NotificationSystem().displayNotification();
    Timer.periodic(Duration(seconds: 1), (Timer t) {
      temp = getAlarm(TimeOfDay.now(), context);
      if(temp != "") {
        triggeredAlarm = temp;
        NotificationSystem().displayNotification();
      }
      });
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            // timer.cancel();
            selectedDestination = index;
            pageTitle = index == 0 ? 'Clock' : 'Alarm';
          });
        },
        selectedIndex: selectedDestination,
        destinations:const [
          NavigationDestination(
            icon: Icon(Icons.alarm),
            label: 'Clock'
            ),
            NavigationDestination(
            icon: Icon(Icons.alarm),
            label: 'Alarm'
            ),
        ],
      ),
      body:  [
        Clock(),
        ListView(
          children: [
            Alarm()
          ],
        )
      ][selectedDestination],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) => AddAlarm()
            ));
        },
        child: const Icon(Icons.add_alarm),
      ),
    );
  }
}
