import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

void main() => runApp(new MyApp());
final reference = FirebaseDatabase.instance.reference().child('users');

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _emailControllerlogin = new TextEditingController();
  TextEditingController _passwordControllerlogin = new TextEditingController();

  TextEditingController _emailControllersignup = new TextEditingController();
  TextEditingController _passwordControllersignup = new TextEditingController();

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  bool _signupClicked = false;
  bool loggedIn = false;
  bool _clicked = false;

  Future<Null> _function() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    this.setState(() {
      if (user != null) {
        print("cool");
        print(user.email);
        print(user.uid);
        print(user.displayName);
        print(user.photoUrl);
        loggedIn = true;
      } else {
        print("not cool");
        loggedIn = false;
      }
    });
  }

  Future<Null> _handleLoginButton(String email, String password) async {
    await _ensureLoggedIn(email, password);
  }

  Future<Null> _ensureLoggedIn(String email, String password) async {
    this.setState(() {
      _clicked = true;
    });
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .catchError((e) {
      print(e); //show error occurred
      scaffoldKey.currentState.showSnackBar(new SnackBar(
        content: new Text("Error!! " + e.toString()),
        duration: new Duration(seconds: 4),
      ));
      this.setState(() {
        _clicked = false;
      });
      return;
    });
    if (user != null) {
      this.setState(() {
        loggedIn = true;
      });
    }
    print(user);
  }

  Future<Null> _handleSignupButton(
      BuildContext context, String email, String password) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((FirebaseUser user) {
      Scaffold.of(context).showSnackBar(new SnackBar(
            content: new Text("Success!"),
          ));
      UserUpdateInfo updateInfo = new UserUpdateInfo();
      updateInfo.displayName = "disp";
      updateInfo.photoUrl = "https://dummyimage.com/300.png/09f/fff";

      FirebaseAuth.instance.updateProfile(updateInfo);
      FirebaseDatabase.instance
          .reference()
          .child('users')
          .child(user.uid)
          .set(user.email);

      this.setState(() {
        loggedIn = true;
      });
      _emailControllersignup.clear();
      _passwordControllersignup.clear();
    }).catchError((e) {
      print(e);
      scaffoldKey.currentState.showSnackBar(new SnackBar(
        content: new Text("Error " + e.toString()),
        duration: new Duration(seconds: 4),
      ));
    });
  }

  Future<Null> logoutUser() async {
    //logout user
    FirebaseAuth.instance.signOut();

    this.setState(() {
      loggedIn = false;
      _signupClicked = false;
    });
  }

  @override
  void initState() {
    super.initState();
    this._function();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    // 24 is for notification bar on Android

    final double itemHeight = (size.height - 24 - kToolbarHeight);
    final double itemWidth = size.width;

    Scaffold loginScaffold = new Scaffold(
      key: scaffoldKey,
      appBar: new AppBar(
        title: new Text("Login", style: new TextStyle(color: Colors.white)),
        backgroundColor: Colors.pink,
      ),
      body: new Container(
        child: Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Container(
                child: new Text(
                  "LOG IN",
                  style: new TextStyle(
                      fontSize: 24.0,
                      letterSpacing: 3.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink),
                ),
              ),
              new Container(
                width: itemWidth - 48,
                margin: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 16.0),
                child: new TextField(
                  decoration: new InputDecoration(
                      hintText: "Email",
                      fillColor: Colors.pink,
                      border: new OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none),
                      icon: new Icon(Icons.email)),
                  controller: _emailControllerlogin,
                ),
              ),
              new Container(
                width: itemWidth - 48,
                margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 28.0),
                child: new TextField(
                  obscureText: true,
                  decoration: new InputDecoration(
                      hintText: "Password",
                      border: new OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none),
                      icon: new Icon(Icons.vpn_key)),
                  controller: _passwordControllerlogin,
                ),
              ),
              !_clicked
                  ? new Container(
                      width: itemWidth / 2,
                      height: 44.0,
                      child: new RaisedButton(
                          elevation: 4.0,
                          color: Colors.pink,
                          child: new Text("Sign In",
                              style: new TextStyle(color: Colors.white)),
                          onPressed: () {
                            _handleLoginButton(_emailControllerlogin.text,
                                _passwordControllerlogin.text);
                          }),
                    )
                  : new Text("doing"),
              new Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
              ),
              new Container(
                width: itemWidth / 2,
                height: 44.0,
                child: new RaisedButton(
                    elevation: 4.0,
                    color: Colors.pink,
                    child: new Text("Sign Up",
                        style: new TextStyle(color: Colors.white)),
                    onPressed: () {
                      this.setState(() {
                        _signupClicked = true;
                      });
                    }),
              )
            ],
          ),
        ),
      ),
    );

    Scaffold signupScaffold = new Scaffold(
        appBar: new AppBar(
          title: new Text("Signup", style: new TextStyle(color: Colors.white)),
          backgroundColor: Colors.pink,
        ),
        body: new Builder(builder: (context) {
          return new Container(
            child: Center(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Container(
                    child: new Text(
                      "SIGN UP",
                      style: new TextStyle(
                          fontSize: 24.0,
                          letterSpacing: 3.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink),
                    ),
                  ),
                  new Container(
                    width: itemWidth - 48,
                    margin: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 16.0),
                    child: new TextField(
                      decoration: new InputDecoration(
                          hintText: "Email",
                          border: new OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none),
                          icon: new Icon(Icons.email)),
                      controller: _emailControllersignup,
                    ),
                  ),
                  new Container(
                    width: itemWidth - 48,
                    margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 28.0),
                    child: new TextField(
                      obscureText: true,
                      decoration: new InputDecoration(
                          hintText: "Password",
                          border: new OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none),
                          icon: new Icon(Icons.vpn_key)),
                      controller: _passwordControllersignup,
                    ),
                  ),
                  new Container(
                    width: itemWidth / 2,
                    height: 44.0,
                    child: new RaisedButton(
                        color: Colors.pink,
                        child: new Text("Sign Up",
                            style: new TextStyle(color: Colors.white)),
                        onPressed: () {
                          _handleSignupButton(
                              context,
                              _emailControllersignup.text,
                              _passwordControllersignup.text);
                        }),
                  ),
                  new Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
                  ),
                  new Container(
                    width: itemWidth / 2,
                    height: 44.0,
                    child: new RaisedButton(
                      color: Colors.pink,
                      onPressed: () {
                        this.setState(() {
                          _signupClicked = false;
                        });
                      },
                      child: new Text(
                        "Back to Sign In",
                        style: new TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }));

    Scaffold homeScaffold = new Scaffold(
        appBar: new AppBar(
          title: new Text("home"),
          actions: <Widget>[
            new IconButton(
                icon: new Icon(Icons.exit_to_app),
                onPressed: () {
                  logoutUser();
                })
          ],
        ),
        body: new Container(
          child: new Stack(alignment: Alignment.bottomRight, children: <Widget>[
            new FirebaseAnimatedList(
              query: reference,
              sort: (a, b) => b.key.compareTo(a.key),
              padding: new EdgeInsets.all(8.0),
              reverse: false,
              itemBuilder: (_, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                return new Text(snapshot.value);
              },
            ),
            new Divider(height: 1.0),
//      new Builder(
//        builder: (BuildContext context) {
//          return new Padding(
//            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 12.0, 12.0),
//            child: new FloatingActionButton(
//              onPressed: () {
//                Navigator.of(context).pushNamed("/chat");
//              },
//              child: new Icon(Icons.chat),
//            ),
//          );
//        },
//      )
          ]),
        ));

    return loggedIn
        ? homeScaffold
        : (_signupClicked ? signupScaffold : loginScaffold);
  }
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("check this works?"),
      ),
    );
  }
}
