part of 'pages.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String title = "Galery Photo";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 30, bottom: 30, left: 15, right: 15),
            child: Column(
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                      fontSize: 35,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
          ),
          StaggeredGridView.countBuilder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: 10,
            crossAxisCount: 2,
            staggeredTileBuilder: (index) => StaggeredTile.fit(1),
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                padding: EdgeInsets.symmetric(vertical: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                    child: Image(image: AssetImage('assets/${index}.jpg')),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailPage(
                            image: "assets/${index}.jpg"
                              )));
                    },
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
