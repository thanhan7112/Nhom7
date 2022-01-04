import 'package:flutter/material.dart';
import '../screens/screens.dart';
import 'package:fluttermovie/api.dart';
import 'package:fluttermovie/models/searchmodel.dart';
import 'details_screen.dart';

// class SearchMovie extends SearchDelegate {
class SearchMovie extends SearchDelegate {
  Api MovieList = Api();
  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        color: Color(0xff009966),

        // ignore: unnecessary_const
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: Theme.of(context)
            .textTheme
            .headline6!
            .copyWith(color: Colors.white),
      ),
      textTheme: TextTheme(
        headline6: TextStyle(color: Colors.white, fontSize: 18),
      ),

      // scaffoldBackgroundColor: Color(0xff006699)
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          color: Colors.amber,
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.close))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<SearchModel>>(
      future: MovieList.getSearchList(MovieName: query),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        List<SearchModel>? data = snapshot.data;
        return ListView.builder(
            itemCount: data?.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(
                            top: 10, bottom: 10, left: 5, right: 10)),
                    Expanded(
                      //sua loi widget
                      child: Container(
                        // padding: EdgeInsets.all(10),

                        height: MediaQuery.of(context).size.height / 6,
                        decoration: BoxDecoration(
                          color: Color(0xff009966),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black,
                                blurRadius: 14.0,
                                offset: Offset(0, 1))
                          ],
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailsScreen(id: data![index].id),
                              ),
                            );
                          },
                          child: Row(
                            children: <Widget>[
                              Positioned.fill(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    getPosterImage(data![index].poster_path),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(height: 10),
                    SizedBox(width: 15),
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          Text(
                            '${data[index].original_title}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Icon(
                            Icons.panorama_photosphere_outlined,
                            size: 20,
                            color: Colors.yellow,
                          ),
                          Text(
                            '${data[index].vote_count}',
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            });
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text('Search Movie'),
    );
  }
}
