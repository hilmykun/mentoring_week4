part of 'product.dart';

class ProductDetail extends StatefulWidget {
  final ProductModel model;
  ProductDetail(this.model);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.model.productName}"),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(10),
                children: <Widget>[
                  Image.network(
                    "http://192.168.56.1/ecommerce-server/imageProduct/${widget.model.cover}",
                    fit: BoxFit.cover,
                    height: 200,
                  ),
                  SizedBox(height: 5),
                  Text(
                    "${widget.model.productName}",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Divider(
                      color: Colors.blue,
                    ),
                  ),
                  Text(
                    "${widget.model.description}",
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.red
              ),
              child: Text(
                "Rp. ${widget.model.sellingPrice}",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
