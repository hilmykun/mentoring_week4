part of 'product.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController productController = TextEditingController();

  TextEditingController priceController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  TextEditingController categoryController = TextEditingController();

  CategoryProductModel model;

  pilihCategory()async{
    model = await Get.to(ChooseCategoryProduct());

    setState(() {
      categoryController = TextEditingController(
        text: model.categoryName
      );
    });
  }

  final _keyForm = GlobalKey<FormState>();

  File image;
  final picker = ImagePicker();

  gallery() async {
    var _image = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      image = File(_image.path);
    });
  }

  save() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(child: Text("Process")),
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CircularProgressIndicator(),
                SizedBox(height: 5),
                Text("Loading...")
              ],
            ),
          ),
        );
      },
    );

    try {
      // ignore: deprecated_member_use
      var stream = http.ByteStream(DelegatingStream.typed(image.openRead()));
      var length = await image.length();
      var url =
          Uri.parse("http://192.168.56.1/ecommerce-server/addProduct.php");
      var multiPartFile = http.MultipartFile("image", stream, length,
          filename: path.basename(image.path));

      var request = http.MultipartRequest("POST", url);
      request.fields['productName'] = productController.text;
      request.fields['sellingPrice'] = priceController.text;
      request.fields['description'] = descriptionController.text;
      request.fields['idCategory'] = model.id;

      request.files.add(multiPartFile);

      var response = await request.send();
      response.stream.transform(utf8.decoder).listen((value) {
        final data = jsonDecode(value);
        int valueGet = data['value'];
        String message = data['message'];

        if (valueGet == 1) {
          Navigator.pop(context);
          print(message);
        } else {
          Navigator.pop(context);
          print(message);
        }
      });
    } catch (e) {
      debugPrint("Error $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: Form(
        key: _keyForm,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: ListView(
            children: [
              InkWell(
                onTap: () {
                  pilihCategory();
                },
                child: TextFormField(
                  enabled: false,
                  controller: categoryController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: "Category Product",
                      hintText: "Product"),
                ),
              ),
              TextFormField(
                controller: productController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: "Product",
                    hintText: "Product"),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: priceController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: "Selling Price",
                    hintText: "Selling Price"),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: "Description",
                    hintText: "Description"),
                maxLines: 3,
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: gallery,
                child: image == null
                    ? Image.asset(
                        'assets/placeholder.png',
                        fit: BoxFit.cover,
                      )
                    : Image.file(
                        image,
                        fit: BoxFit.cover,
                      ),
              ),
              SizedBox(height: 15),
              Container(
                height: 40,
                child: RaisedButton(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0)),
                    padding: EdgeInsets.all(0.0),
                    child: Ink(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.blue, Colors.red],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: 200,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Create",
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    onPressed: () {
                      save();
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
