import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResetScreen extends StatefulWidget {
  @override
  _ResetScreenState createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  late String _email;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
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
      body: Column(
        children: <Widget>[
          SizedBox(
              height: 180,
              child: Image.asset(
                "assets/image/bgr.png",
                fit: BoxFit.contain,
              )),
          SizedBox(height: 45),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextFormField(
              style: TextStyle(color: Colors.white),
              autofocus: false,
              validator: (value) {
                if (value!.isEmpty) {
                  return ("please enter email ! ");
                } else {
                  return ("Check mail");
                }
              },
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.mail,
                  color: Colors.white,
                ),
                contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                hintText: "Email",
                hintStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10).copyWith(),
                  borderSide: BorderSide(color: Colors.white, width: 1.0),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10).copyWith(),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _email = value.trim();
                });
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(30).copyWith(),
                color: Colors.white,
                child: MaterialButton(
                  child: Text(
                    "Reset Password",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                  ),
                  onPressed: () {
                    auth.sendPasswordResetEmail(email: _email);
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
