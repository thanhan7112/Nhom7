import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttermovie/global.dart';
import 'package:fluttermovie/models/moviemodel.dart';
import 'package:fluttermovie/ui/widgets/widgets.dart';

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
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            "${snapshot.data!.original_title}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .apply(color: Colors.white),
                          ),
                          SizedBox(
                            height: 7.0,
                          ),
                          RichText(
                            text: TextSpan(
                              children: List.generate(
                                snapshot.data!.genre.length,
                                (i) {
                                  return TextSpan(
                                      text:
                                          //Dòng chữ nhỏ dưới tên phim
                                          "${snapshot.data!.genre[i]['name']} ");
                                },
                              ),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .apply(color: Colors.white),
                            ),
                          ),
                          SizedBox(height: 9.0),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RatingBar.builder(
                                initialRating: snapshot.data!.rating,
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
                                  print(rating);
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
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .apply(color: Colors.white),
                                  ),
                                  Text(
                                    "${DateTime.parse(snapshot.data!.release_date).year}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .apply(color: Color(0xff0099CC)),
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Text(
                                    "Country",
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .apply(color: Colors.white),
                                  ),
                                  Text(
                                    "${snapshot.data!.country}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .apply(color: Color(0xff0099CC)),
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Text(
                                    "Length",
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .apply(color: Colors.white),
                                  ),
                                  Text(
                                    "${snapshot.data!.run_time} min",
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .apply(color: Color(0xff0099CC)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 13.0),
                          Text(
                            "${snapshot.data!.overview}",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .apply(color: Colors.white),
                          ),
                          SizedBox(height: 13.0),
                        ],
                      ),
                    ),
                    SizedBox(height: 13.0),
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
