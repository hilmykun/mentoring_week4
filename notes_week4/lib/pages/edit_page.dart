part of 'pages.dart';

class EditData extends StatefulWidget {
  final List list;
  final int index;

  EditData({this.index, this.list});

  @override
  _EditDataState createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  TextEditingController titleN;
  TextEditingController contentN;

  void editData() {
    var url = "http://192.168.56.1/diaryku-server/edit.php";
    http.post(url, body: {
      'id': widget.list[widget.index]['id'],
      'title': titleN.text,
      'content': contentN.text
    });
  }

  @override
  void initState() {
    titleN =
        new TextEditingController(text: widget.list[widget.index]['title']);
    contentN =
        new TextEditingController(text: widget.list[widget.index]['content']);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Note"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 15)),
            TextField(
              controller: titleN,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            Padding(padding: EdgeInsets.only(top: 15)),
            TextField(
              controller: contentN,
              decoration: InputDecoration(labelText: 'Content'),
            ),
             Padding(padding: EdgeInsets.only(top: 15)),
             RaisedButton(
               child: Text('Save'),
               color: Colors.blue,
               onPressed: (){
                 editData();
                 toast("Edit Success!");
                 Get.offAndToNamed('/main');
               },
             )
          ],
        ),
      ),
    );
  }
  toast(String message) {
    return Fluttertoast.showToast(
        msg: message,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.blue[200],
        textColor: Colors.white,
        fontSize: 15);
  }
}
