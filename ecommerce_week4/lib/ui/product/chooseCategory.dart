part of 'product.dart';

class ChooseCategoryProduct extends StatefulWidget {
  @override
  _ChooseCategoryProductState createState() => _ChooseCategoryProductState();
}

class _ChooseCategoryProductState extends State<ChooseCategoryProduct> {

  var loading = false;

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

  @override
  void initState() {
    getProductWithCategory();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose Category Product"),
      ),
      body: Container(
        child: loading ? Center(
          child: CircularProgressIndicator(),
        ): ListView.builder(
          itemCount: listCategory.length,
          itemBuilder: (context, i) {
            final a = listCategory[i];
            return InkWell(
              onTap: (){
                Navigator.pop(context, a);
              },
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(a.categoryName),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Divider(
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
            );
          },),
      ),
    );
  }
}