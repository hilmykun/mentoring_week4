part of 'pages.dart';

class AddData extends StatefulWidget {
  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  TextEditingController titleN = TextEditingController();
  TextEditingController contentN = TextEditingController();

  void addData() {
    var url = "http://192.168.56.1/diaryku-server/add.php";
    http.post(url, body: {'title': titleN.text, 'content': contentN.text});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Diary-KU"),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 15),
                ),
                TextField(
                  controller: titleN,
                  decoration: InputDecoration(labelText: 'Title'),
                ),
                Padding(padding: EdgeInsets.all(10)),
                TextField(
                  controller: contentN,
                  decoration: InputDecoration(labelText: 'Content'),
                ),
                Padding(padding: EdgeInsets.all(5)),
                RaisedButton(
                    child: Text("Save"),
                    color: Colors.red,
                    onPressed: () {
                      addData();
                      toast("Daftar Diary-KU Success");
                      Get.offAndToNamed('/main');
                    })
              ],
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
