import '../commons/imports.dart';

class NotificationSystem {
  static var channel = const AndroidNotificationChannel(
    'channel id',
    'channel name',
    description: 'this is channel for sending message',
    importance: Importance.max,
    playSound: true
  );

   static Future notificationPlugin() async {
    await FlutterLocalNotificationsPlugin().
      resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()!.
          createNotificationChannel(channel);

    await FlutterLocalNotificationsPlugin().
      resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()!.
          requestNotificationsPermission();

    var androidSettings = AndroidInitializationSettings('app_icon');
    var settings = InitializationSettings(android: androidSettings);

    await FlutterLocalNotificationsPlugin().initialize(
      settings,
      onDidReceiveNotificationResponse: (NotificationResponse res) {
        if(res.actionId == '1') {
          print('Dismiss on Message: ${res.actionId}');
          snoozeTimer.cancel();
          triggeredAlarm = '';
        }else {
          snoozeTimer = Timer.periodic(const Duration(seconds: 10), (Timer t) {
            print('snooze for 10 seconds');
            if(triggeredAlarm != '') {
              NotificationSystem().displayNotification();
            }
          });
        }
      },
    );
  }
      void displayNotification() async {
        List<String> temp;
        temp = triggeredAlarm != ""? triggeredAlarm.split('&'): [];
      await FlutterLocalNotificationsPlugin().show(
        0,
        temp.isNotEmpty? '${temp[0]} alarm':"",
        temp.isNotEmpty? '${temp[1]}':"",
        NotificationDetails(
          android: AndroidNotificationDetails(
            actions: const[
              AndroidNotificationAction(
                '1',
                'Dismiss',
                showsUserInterface: true
                ),
                AndroidNotificationAction(
                '2',
                'snooze',
                 showsUserInterface: true
                ),
            ],
            // timeoutAfter: const Duration(seconds: 20).inMilliseconds,
            channel.id,
            channel.name,
            channelDescription: channel.description,
            importance: Importance.max,
            priority: Priority.high,
            color: Colors.blue,
            playSound: true,
        ),
      )
      );
    }
}
  