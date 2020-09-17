part of 'pages.dart';

enum statusLogin { signIn, notSignIn }

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //Key global
  final _keyForm = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  //Kondisi login status
  statusLogin _loginStatus = statusLogin.notSignIn;

  //variabel
  String nUsername;
  String nPassword;

  //Check login
  checkForm() {
    final form = _keyForm.currentState;
    if (form.validate()) {
      form.save();
      submitDataLogin();
      toast("Login Succes");
    }
  }

  @override
  void initState() {
    getDataPref();
    super.initState();
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

  //Method SignOut
  signOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      sharedPreferences.setInt("value", null);
      _loginStatus = statusLogin.notSignIn;
    });
  }

  //View password
  bool _isHidePassword = true;

  void _togglePasswordVisibility() {
    setState(() {
      _isHidePassword = !_isHidePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case statusLogin.notSignIn:
        return Scaffold(
          backgroundColor: Colors.yellow[100],
          body: Form(
            key: _keyForm,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Center(
                child: ListView(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 20),
                        SizedBox(
                          height: 70,
                          child: GradientText("Diary-KU",
                              gradient: LinearGradient(
                                  colors: [Colors.blue, Colors.red]),
                              style: GoogleFonts.poppins(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                        SizedBox(height: 65),
                        TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please Input Username';
                            }
                            return null;
                          },
                          onSaved: (value) => nUsername = value,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.account_circle),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              labelText: "Username",
                              hintText: "Username"),
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          validator: (value) {
                            //cek value apakah ada atau tidak
                            if (value.isEmpty) {
                              return 'Please input password';
                            } else {
                              return null;
                            }
                          },
                          obscureText: _isHidePassword,
                          onSaved: (value) => nPassword = value,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock_outline),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  _togglePasswordVisibility();
                                },
                                child: Icon(
                                  _isHidePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: _isHidePassword
                                      ? Colors.grey
                                      : Colors.blue,
                                ),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              labelText: "Password",
                              hintText: "Password"),
                        ),
                        SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              "Forget Password?",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300),
                            ),
                            Text(
                              "Click Here",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 12),
                            ),
                          ],
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
                                    borderRadius: BorderRadius.circular(30.0)),
                                child: Container(
                                  constraints: BoxConstraints(maxWidth: 200.0),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Login",
                                    style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  checkForm();
                                });
                              }),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Belum punya akun?",
                              style: TextStyle(color: Colors.grey),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed('/register');
                              },
                              child: Text(
                                "Register",
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
        break;
      case statusLogin.signIn:
        return MainPage();
        break;
    }
  }

  //Mengirim APi Request
  submitDataLogin() async {
    var data;
    try {
      final responseData = await http.post(
          "http://192.168.56.1/diaryku-server/login.php",
          body: {"username": nUsername, "password": nPassword});
      if (responseData.statusCode == 200) {
        data = jsonDecode(responseData.body);
      }
    } on SocketException {
      print("Error");
    }

    int value = data['value'];
    String pesan = data['message'];
    print(data);

    String dataUsername = data['username'];
    String dataEmail = data['email'];
    String dataIdUser = data['id_user'];

    if (value == 1) {
      setState(() {
        _loginStatus = statusLogin.signIn;
        saveDataPref(value, dataIdUser, dataUsername, dataEmail);
      });
    } else if (value == 2) {
      print(pesan);
    } else {
      print(pesan);
    }
  }

  saveDataPref(
      int value, String dIdUser, String dUsername, String dEmail) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      sharedPreferences.setInt("value", value);
      sharedPreferences.setString("username", dUsername);
      sharedPreferences.setString("id_user", dIdUser);
      sharedPreferences.setString("email", dEmail);
    });
  }

  getDataPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      int nvalue = sharedPreferences.getInt("value");
      _loginStatus = nvalue == 1 ? statusLogin.signIn : statusLogin.notSignIn;
    });
  }
}
