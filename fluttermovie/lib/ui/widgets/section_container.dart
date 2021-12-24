import 'package:flutter/material.dart';

class SectionContainer extends StatelessWidget {
  final Widget child;
  final String sectionTitle;
  const SectionContainer(
      {Key? key, required this.child, required this.sectionTitle})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 12.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                sectionTitle,
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Spacer(),
              Icon(
                Icons.switch_left_sharp,
                color: Colors.black,
              ),
              const SizedBox(width: 15.0),
            ],
          ),
          SizedBox(
            height: 2,
          ),
          child,
        ],
      ),
    );
  }
}
