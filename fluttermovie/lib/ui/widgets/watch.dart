import 'package:flutter/material.dart';

class watch extends StatelessWidget {
  final String imgUrl;

  const watch({Key? key, required this.imgUrl}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 3.0, left: 10, right: 10),
      height: MediaQuery.of(context).size.height / 2.5,
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 55,
            left: 0,
            right: 0,
            top: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              // clipper: CustomClip(),
              child: Image.network(
                "$imgUrl",
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Positioned(
            right: 0,
            left: 0,
            child: Container(
              color:
                  Colors.black.withOpacity(0.4), //khung chứa tmdb đã bị làm mờ
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    "TMDB",
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .apply(color: Colors.white),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.bookmark_add_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
