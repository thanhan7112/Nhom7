import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttermovie/api.dart';
import 'package:fluttermovie/models/moviemodel.dart';
import 'package:fluttermovie/ui/widgets/widgets.dart';
import 'package:fluttermovie/ui/screens/screens.dart';
import '../../api.dart';

class DetailsScreen extends StatefulWidget {
  final int id;

  const DetailsScreen({Key? key, required this.id}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late Api _api;
  late Future<MovieModel> movieModel;
  @override
  void initState() {
    _api = Api();
    movieModel = _api.getMovieInfo(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: FutureBuilder<MovieModel>(
          future: movieModel,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    watch(
                      imgUrl: getPosterImage(snapshot.data!.poster_path),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            "${snapshot.data!.original_title}",
                            style: TextStyle(
                              color: Colors.yellow,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          RichText(
                            text: TextSpan(
                              children: List.generate(
                                snapshot.data!.genre.length,
                                (i) {
                                  return TextSpan(
                                      text:
                                          //Dòng chữ nhỏ dưới tên phim
                                          "${snapshot.data!.genre[i]['name']}");
                                },
                              ),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: "Raleway-Regular",
                              ),
                            ),
                          ),
                          SizedBox(height: 15.0),
                          Padding(
                            padding: EdgeInsets.only(left: 165),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: -4,
                                  child: Icon(
                                    Icons.thumb_up_alt_outlined,
                                    size: 20,
                                    color: Colors.yellow,
                                  ),
                                ),
                                Expanded(
                                  flex: 8,
                                  child: Text(
                                    "${snapshot.data!.vote_count}",
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
                          SizedBox(height: 15.0),
                          Text(
                            "${snapshot.data!.rating}/10",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.yellow,
                              fontSize: 18,
                              fontFamily: "Raleway-Regular",
                            ),
                          ),
                          SizedBox(height: 15.0),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RatingBar.builder(
                                initialRating: snapshot.data!.rating, //hang sao
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                itemSize: 25,
                                onRatingUpdate: (rating) {
                                  print(rating); //review
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 13.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Text(
                                    "Year",
                                    style: TextStyle(
                                      color: Colors.yellow,
                                      fontSize: 16,
                                      fontFamily: "Raleway-Regular",
                                    ),
                                  ),
                                  Text(
                                    "${DateTime.parse(snapshot.data!.release_date).year}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: "Raleway-Regular",
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Text(
                                    "Country",
                                    style: TextStyle(
                                      color: Colors.yellow,
                                      fontSize: 16,
                                      fontFamily: "Raleway-Regular",
                                    ),
                                  ),
                                  Text(
                                    "${snapshot.data!.country}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: "Raleway-Regular",
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Text(
                                    "Length",
                                    style: TextStyle(
                                      color: Colors.yellow,
                                      fontSize: 16,
                                      fontFamily: "Raleway-Regular",
                                    ),
                                  ),
                                  Text(
                                    "${snapshot.data!.run_time} min",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: "Raleway-Regular",
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 13.0),
                          Text(
                            "Review",
                            style: TextStyle(
                              color: Colors.yellow,
                              fontSize: 20,
                              fontFamily: "Raleway-Regular",
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "${snapshot.data!.overview}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: "Raleway-Regular",
                            ),
                          ),
                          SizedBox(height: 15.0),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, VideoApp.route);
                                  },
                                  child: Container(
                                    width: 150.0,
                                    height: 60.0,
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Trailer',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "Raleway-Regular",
                                          fontSize: 20.0),
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Container(
                                  padding: const EdgeInsets.all(16.0),
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.share,
                                    color: Colors.black,
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.white),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  padding: const EdgeInsets.all(16.0),
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.bookmark,
                                    color: Colors.black,
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15.0),
                  ],
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
