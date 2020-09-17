part of 'pages.dart';

enum statusLogin { signIn, notSignIn }

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  statusLogin _loginStatus = statusLogin.notSignIn;

  final _keyFrom = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  String nUsername;
  String nPassword;

  //Check Ketika Ingin Login
  checkForm() {
    final form = _keyFrom.currentState;
    if (form.validate()) {
      form.save();
      submitDataLogin();
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

  //Method signout
  signOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      sharedPreferences.setInt('value', null);
      _loginStatus = statusLogin.notSignIn;
    });
  }

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
          key: scaffoldKey,
          body: Form(
            key: _keyFrom,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Center(
                child: ListView(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 20),
                        Container(
                          height: 250,
                          child: Image.asset('assets/pelihara.png'),
                        ),
                        SizedBox(
                          height: 30,
                          child: Text("Welcome Back!",
                              style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[900])),
                        ),
                        SizedBox(
                          height: 40,
                          child: Text(
                            "Sign In Continue",
                            style: GoogleFonts.poppins(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ),
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
                                  borderRadius: BorderRadius.circular(30)),
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
                                  borderRadius: BorderRadius.circular(30)),
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
                          width: 200,
                          child: RaisedButton(
                              elevation: 0,
                              color: Colors.blue[900],
                              shape: StadiumBorder(),
                              child: Text(
                                "Login",
                                style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
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
                              "Not Have Account?",
                              style: TextStyle(color: Colors.grey),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(RegisterPage());
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
        return MainPage(signOut);
        break;
    }
  }

  void submitDataLogin() async {
    var data;
    try {
      final responseData = await http
          .post("http://192.168.56.1/ecommerce-server/login.php", body: {
        "username": nUsername,
        "password": nPassword,
      });
      if (responseData.statusCode == 200) {
        data = jsonDecode(responseData.body);
      }
    } on SocketException {
      print("Error");
    }

    int value = data['value'];
    String message = data['message'];
    print(message);

    String dataUsername = data['username'];
    String dataEmail = data['email'];
    String dataIdUser = data['id_user'];

    if (value == 1) {
      setState(() {
        _loginStatus = statusLogin.signIn;
        saveDataPref(value, dataIdUser, dataUsername, dataEmail);
      });
    }
    toast(message);
  }

  saveDataPref(
      int value, String dIdUser, String dUsername, String dEmail) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      sharedPreferences.setInt('value', value);
      sharedPreferences.setString('username', dUsername);
      sharedPreferences.setString('id_user', dIdUser);
      sharedPreferences.setString('email', dEmail);
    });
  }

  getDataPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      int nvalue = sharedPreferences.getInt('value');
      _loginStatus = nvalue == 1 ? statusLogin.signIn : statusLogin.notSignIn;
    });
  }
}
