part of 'pages.dart';

class DetailPage extends StatelessWidget {
  final String image;
  DetailPage({Key key, this.image}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(image),
    );
  }
}
