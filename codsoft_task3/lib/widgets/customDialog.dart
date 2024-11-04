import '../commons/imports.dart';

class CustomDialog extends StatefulWidget {
  DialogState createState() => DialogState();
}

class DialogState extends State<CustomDialog> {
  Widget build(BuildContext context) {
    return AlertDialog(
    title: Text('Ringtone'),
    content: Column(
      mainAxisSize: MainAxisSize.values.first,
      children: [
        ...dialogContent(ringtones())
      ],
    ),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.pop(context);
          setState(() {});},
      child: Text('ok')),
      TextButton(
        onPressed: () {Navigator.pop(context);},
      child: Text('cancel'))
    ],
  );
  }

  List<ListTile> dialogContent(List<String> ringtones) {
    List<ListTile> temp = [];
    for(String tone in ringtones) {
      temp.add(
        ListTile(
          title: Text(tone),
          leading: Radio(
            value: tone, 
            groupValue: selectedRadio,
             onChanged: (String? value) {
              setState(() {
                selectedRadio = value;
              });
             }
            ),
        )
      );
    }
    return temp;
  }
  List<String> ringtones() {
  List<String> temp = [];
  temp.add('prokerala');
  temp.add('Rajdip');
  temp.add('Santo');
  temp.add('Patel');
  temp.add('Awais');
  temp.add('Lokendra');
  temp.add('Smile');
  temp.add('Debabrata');
  temp.add('Pervez');
  temp.add('Nagarani');
  return temp;
}

}