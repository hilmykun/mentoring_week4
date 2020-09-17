part of 'pages.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController cUsername = TextEditingController();
  TextEditingController cPassword = TextEditingController();
  TextEditingController cEmail = TextEditingController();

  final _keyForm = GlobalKey<FormState>();

  ///Deklari untuk masing2 widget
  String nUsername, nPassword, nEmail;

  /// Cek ketika sudah daftar
  checkForm() {
    final form = _keyForm.currentState;
    if (form.validate()) {
      form.save();
      submitDataRegister();
    }
  }
 
  //Alert message

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow[100],
        body: Form(
          key: _keyForm,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: ListView(
              children: <Widget>[
                SizedBox(height: 20),
                Container(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(Icons.arrow_back)),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                        height: 70,
                        child: GradientText(
                          "Let's Get Started!",
                          gradient:
                              LinearGradient(colors: [Colors.blue, Colors.red]),
                          style: GoogleFonts.poppins(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        )),
                    SizedBox(
                        height: 20,
                        child: Text(
                          "Create account to start Fish Shop",
                          style: GoogleFonts.poppins(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        )),
                    SizedBox(
                      height: 65,
                    ),
                    TextFormField(
                      controller: cUsername,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please input username';
                        }
                        return null;
                      },
                      onSaved: (value) => nUsername = cUsername.text,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.account_circle),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: "Username",
                          hintText: "Username"),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: cEmail,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please input email';
                        }
                        return null;
                      },
                      onSaved: (value) => nEmail = cEmail.text,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: "Email Address",
                          hintText: "Email Address"),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: cPassword,
                      obscureText: true,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please input password';
                        }
                        return null;
                      },
                      onSaved: (value) => nPassword = cPassword.text,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock_outline),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: "Password",
                          hintText: "Password"),
                    ),
                    SizedBox(height: 20),
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
                            setState(() {
                              checkForm();
                            });
                          }),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }

  void submitDataRegister() async {
    final responseData = await http
        .post("http://192.168.56.1/ecommerce-server/register.php", body: {
      "username": nUsername,
      "password": nPassword,
      "email": nEmail,
    });
    final data = jsonDecode(responseData.body);

    int value = data['value'];
    String message = data['message'];

    if (value == 1) {
      setState(() {
        Navigator.pop(context);
      });
    }
    toast(message);
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
