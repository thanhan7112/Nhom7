import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttermovie/ui/screens/login_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ResetScreen extends StatefulWidget {
  @override
  _ResetScreenState createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = new TextEditingController();
  // late String _email;
  final _auth = FirebaseAuth.instance;
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      style: TextStyle(color: Colors.white),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter Your Email");
        }
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please Enter a valid email");
        }
        return null;
      },
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        // fillColor: Colors.white,
        prefixIcon: Icon(
          Icons.mail,
          color: Colors.white,
        ),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Reset",
        hintStyle: TextStyle(color: Color(0xffCCCCCC)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10).copyWith(),
          // width: 0.0 produces a thin "hairline" border
          borderSide: BorderSide(color: Colors.white, width: 1.0),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10).copyWith(),
        ),
      ),
    );

    final ResetButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30).copyWith(),
      color: Colors.white,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          Reset(
            emailController.text,
          );
        },
        child: Text(
          "Reset",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                        height: 100,
                        child: Image.asset(
                          "assets/image/bgr.png",
                          fit: BoxFit.contain,
                        )),
                    SizedBox(height: 45),
                    emailField,
                    SizedBox(height: 25),
                    ResetButton,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void Reset(String email) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .sendPasswordResetEmail(email: email)
            // .signInWithEmailAndPassword(email: email)
            .then((uid) => {
                  Fluttertoast.showToast(msg: "Reset Successful"),
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginScreen())),
                });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }
}
