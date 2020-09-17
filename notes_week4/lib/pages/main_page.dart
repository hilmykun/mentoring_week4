part of 'pages.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var loading = false;

  signOut() async {
    setState(() {});
  }

  String username = "";
  String email = "";

  getDataPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      username = sharedPreferences.getString("username");
    });
  }

  @override
  void initState() {
    getDataPref();
    getData();
    super.initState();
  }

  Future<List> getData() async {
    var url = 'http://192.168.56.1/diaryku-server/read.php';
    var response = await http.get(url);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //membuat Action button untuk menambahkan data
      floatingActionButton: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          splashColor: Colors.blue[200],
          backgroundColor: Colors.blueGrey[100],
          child: Icon(
            Icons.add,
            color: Colors.black,
          ),
          onPressed: () {
            Get.toNamed('/add');
            //aksi untuk nambah Diary-KU
          }),

      backgroundColor: Colors.white,
      body: FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ItemList(list: snapshot.data)
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ItemList extends StatefulWidget {
  final List list;
  final int index;
  ItemList({this.list, this.index});

  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  String username = "";
  getDataPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      username = sharedPreferences.getString("username");
    });
  }

  @override
  void initState() {
    getDataPref();
    super.initState();
  }

  void deleteData() {
    var url = "http://192.168.56.1/diaryku-server/delete.php";
    http.post(url, body: {'id': widget.list[widget.index]['id']});
  }

  void confirm() {
    AlertDialog alertDialog = new AlertDialog(
      content:
          Text("Delete this diary? '${widget.list[widget.index]['title']}'"),
      actions: <Widget>[
        RaisedButton(
          child: Text('Deleted Note'),
          color: Colors.red,
          onPressed: () {
            deleteData();
            toast("deleted Succes");
            Get.offAndToNamed('/main');
          },
        ),
        RaisedButton(
          child: Text('Cancel'),
          color: Colors.red,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
    showDialog(context: context, child: alertDialog);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome, " + username,
            style: GoogleFonts.poppins(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold)),
      ),
      body: ListView.builder(
        itemCount: widget.list == null ? 0 : widget.list.length,
        itemBuilder: (context, index) {
          return Container(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => DetailData(
                          list: widget.list,
                          index: index,
                        )));
              },
              child: Card(
                color: Colors.blue,
                child: ListTile(
                  title: Text(widget.list[index]['title']),
                  subtitle: Text(widget.list[index]['content']),
                  leading: Icon(Icons.list),
                ),
              ),
            ),
          );
        },
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
