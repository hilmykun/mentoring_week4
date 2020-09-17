part of 'pages.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //Deklarasi variabel controller
  TextEditingController cUsername = TextEditingController();
  TextEditingController cPassword = TextEditingController();
  TextEditingController cEmail = TextEditingController();

  //Deklari untuk masing2 widget
  String nUsername, nPassword, nEmail;

  //Cek ketika sudah daftar
  checkForm() {
    final form = _keyForm.currentState;
    if (form.validate()) {
      form.save();
      submitDataRegister();
      toast("Success Register");
    }
  }

  //Alert message
  toast(String message) {
    return Fluttertoast.showToast(
        msg: message,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.blue[200],
        textColor: Colors.white,
        fontSize: 15);
  }

  final _keyForm = GlobalKey<FormState>();
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
                              fontSize: 50, fontWeight: FontWeight.bold),
                        )),
                    SizedBox(
                        height: 20,
                        child: Text(
                          "Create account to start Diary-KU!",
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

  //Services data register
  void submitDataRegister() async {
    final responseData = await http
        .post("http://192.168.56.1/diaryku-server/register.php", body: {
      "username": nUsername,
      "password": nPassword,
      "email": nEmail,
    });

    final data = jsonDecode(responseData.body);

    int value = data['value'];
    String pesan = data['message'];

    if (value == 1) {
      setState(() {
        Get.toNamed('login');
      });
    } else if (value == 2) {
      print(pesan);
    } else {
      print(pesan);
    }
  }
}
