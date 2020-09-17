part of 'pages.dart';

class MainPage extends StatefulWidget {
  final VoidCallback signOut;
  MainPage(this.signOut);
  @override
  _MainPageState createState() => _MainPageState();
}

final price = NumberFormat("#, ##0", 'en_US');

var filter = false;

class _MainPageState extends State<MainPage> {
  /// *variabel loading
  var loading = false;

  ///* Menampilkan list dari  model  *category*
  List<CategoryProductModel> listCategory = [];
  getProductWithCategory() async {
    setState(() {
      loading = true;
    });

    listCategory.clear();
    final response = await http.get(NetworkUrl.getProductCategory());
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      setState(() {
        for (Map i in data) {
          listCategory.add(CategoryProductModel.fromJson(i));
        }
        loading = false;
      });
    } else {
      setState(() {
        loading = false;
      });
    }
  }

  ///* Menampilkan list dari model *product*
  List<ProductModel> list = [];

  ///* Method logic untuk get Product
  getProduct() async {
    setState(() {
      loading = true;
    });

    list.clear();
    final response =
        await http.get("http://192.168.56.1/ecommerce-server/getProduct.php");
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      setState(() {
        for (Map i in data) {
          list.add(ProductModel.fromJson(i));
        }
        loading = false;
      });
    } else {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    getProduct();
    getDataPref();
    getProductWithCategory();
    super.initState();
  }

  signOut() async {
    setState(() {
      widget.signOut();
    });
  }

  String username = "";
  getDataPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      username = sharedPreferences.getString("username");
    });
  }

  _showAlert() {
    Get.snackbar('Logout', 'Logout Success');
  }

  Future<void> onRefresh() async {
    getProduct();
    getProductWithCategory();
    filter = false;
  }

  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent[200],
          title: Text(
            'Welcome,' + username,
            style: whiteTextFont.copyWith(fontSize: 20),
          ),
          actions: [
            Container(
                width: 100,
                child: GestureDetector(
                    onTap: () {
                      signOut();
                      _showAlert();
                    },
                    child: Center(
                      child: Text(
                        'Sign Out',
                        style: whiteTextFont.copyWith(fontSize: 15),
                      ),
                    )))
          ],
        ),
        floatingActionButton: InkWell(
          onTap: () {
            Get.to(AddProduct());
          },
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.blue),
            child: Icon(
              Icons.add_shopping_cart,
              color: Colors.white,
            ),
          ),
        ),
        body: loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: onRefresh,
                child: ListView(
                  children: <Widget>[
                    ///* UI Untuk list Kategory Product
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 50,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: listCategory.length,
                        itemBuilder: (context, i) {
                          final a = listCategory[i];
                          return InkWell(
                            onTap: () {
                              setState(() {
                                filter = true;
                                index = i;
                                print(filter);
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 12, left: 12),
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.red),
                              child: Text(
                                a.categoryName,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    ///* UI Product
                    filter
                        ? listCategory[index].product.length == 0
                            ? Container(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[Text("Sorry Not Product",
                                  textAlign: TextAlign.center,)],
                                ),
                              )
                            : GridView.builder(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                padding: EdgeInsets.all(10),
                                itemCount: listCategory[index].product.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 16,
                                        crossAxisSpacing: 16),
                                itemBuilder: (context, i) {
                                  final a = listCategory[index].product[i];

                                  return InkWell(
                                    onTap: () {
                                      Get.to(ProductDetail(a));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 2,
                                              color: Colors.grey[200]),
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                                blurRadius: 4,
                                                color: Colors.grey[200])
                                          ]),
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: <Widget>[
                                          Expanded(
                                            child: Image.network(
                                              "http://192.168.56.1/ecommerce-server/imageProduct/${a.cover}",
                                              fit: BoxFit.cover,
                                              height: 75,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            "${a.productName}",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "Rp. ${a.sellingPrice}",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              )
                        : GridView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: list.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10),
                            itemBuilder: (context, i) {
                              final a = list[i];

                              return InkWell(
                                onTap: () {
                                  Get.to(ProductDetail(a));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 2, color: Colors.grey[200]),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 4,
                                            color: Colors.grey[200])
                                      ]),
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      Expanded(
                                        child: Image.network(
                                          "http://192.168.56.1/ecommerce-server/imageProduct/${a.cover}",
                                          fit: BoxFit.cover,
                                          height: 75,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        "${a.productName}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Rp. ${a.sellingPrice}",
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ],
                ),
              ));
  }
}
