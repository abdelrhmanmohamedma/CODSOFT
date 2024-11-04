import '../commons/imports.dart';

class CustomNavigationbar extends StatefulWidget {
  NavigationbarState createState() => NavigationbarState();
}

class NavigationbarState extends State<CustomNavigationbar> {
  int selectedDestination = 0;
  
  void initState() {
    selectedDestination = 0;

    super.initState();
  }

  Widget build(BuildContext context) {
    return NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
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
      );
  }
}