part of 'pages.dart';

class DetailData extends StatefulWidget {
  final List list;
  final int index;

  DetailData({this.list, this.index});

  @override
  _DetailDataState createState() => _DetailDataState();
}

class _DetailDataState extends State<DetailData> {
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
            toast("deleted Data Succes!");
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
  toast(String message) {
    return Fluttertoast.showToast(
        msg: message,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.blue[200],
        textColor: Colors.white,
        fontSize: 15);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Detail Diary, '${widget.list[widget.index]['title']}'"),
          actions: [
            GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => EditData(
                            list: widget.list,
                            index: widget.index,
                          )));
                },
                child: Icon(Icons.edit)),
            GestureDetector(
                onTap: () {
                  confirm();
                },
                child: Icon(Icons.delete)),
          ],
          backgroundColor: Colors.green,
        ),
        body: StaggeredGridView.countBuilder(
          padding: EdgeInsets.all(10),
          crossAxisCount: 1,
          itemCount: 1,
          physics: ScrollPhysics(),
          shrinkWrap: true,
          staggeredTileBuilder: (index) {
            return StaggeredTile.fit(1);
          },
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.all(6),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditData(
                                list: widget.list,
                                index: widget.index,
                              )));
                },
                child: Container(
                  padding: EdgeInsets.all(13),
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: Color(0xFF606267), width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: <Widget>[
                      Text(
                        widget.list[widget.index]['title'],
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w600),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 10),
                      Text(
                        widget.list[widget.index]['content'],
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                        maxLines: 11,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
