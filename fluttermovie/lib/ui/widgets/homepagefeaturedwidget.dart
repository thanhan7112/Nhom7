import 'package:flutter/material.dart';
import 'package:fluttermovie/models/featuredmoviemodel.dart';
import 'package:fluttermovie/api.dart';

class HomePageFeaturedWidget extends StatelessWidget {
  final AsyncSnapshot<List<FeaturedMovieModel>> snapshot;
  const HomePageFeaturedWidget({
    Key? key,
    required this.snapshot,
  }) : super(key: key);

  @override
  //poster lớn ở đầu màn hình home
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: snapshot.data!.length,
      itemBuilder: (ctx, id) {
        return Container(
          // width: MediaQuery.of(context).size.width / 5,
          margin: EdgeInsets.only(top: 15, left: 15, bottom: 15, right: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                  blurRadius: 12.0, color: Colors.black, offset: Offset(0, 1))
            ],
          ),
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.network(
                    getPosterImage(snapshot.data![id].poster_path),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              //bóng mờ chứa text
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                    color: Colors.black45,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${snapshot.data![id].original_title}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                          softWrap: true,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Expanded(
                        flex: -1,
                        child: Icon(
                          Icons.panorama_photosphere_outlined,
                          size: 20,
                          color: Colors.yellow,
                        ),
                      ),
                      Expanded(
                        flex: -2,
                        child: Text(
                          "${snapshot.data![id].rating}/10",
                          style: TextStyle(
                            color: Colors.yellow,
                            fontSize: 16,
                            fontFamily: "Raleway-Regular",
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
