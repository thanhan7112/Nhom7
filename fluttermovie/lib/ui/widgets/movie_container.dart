import 'package:flutter/material.dart';
import 'package:fluttermovie/api.dart';
import 'package:fluttermovie/models/featuredmoviemodel.dart';
import '../screens/screens.dart';

class MovieContainer extends StatelessWidget {
  final FeaturedMovieModel snapshot;

  const MovieContainer({
    Key? key,
    required this.snapshot,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            //Chuyen den man hinh detailscreen
            builder: (ctx) => DetailsScreen(id: snapshot.id),
          ),
        );
      },
      //bóng
      child: Container(
        width: MediaQuery.of(context).size.width / 2.5,
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                blurRadius: 12.0, color: Colors.black, offset: Offset(0, 1))
          ],
        ),
        //box phim
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  getPosterImage(snapshot.poster_path),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            //Lớp phủ màu xóm chứa tên phim
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                  color: Colors.black45,
                ),
                child: Text(
                  snapshot.original_title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
