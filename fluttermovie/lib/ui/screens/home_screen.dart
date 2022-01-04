import 'package:flutter/material.dart';
import 'package:fluttermovie/api.dart';
import 'package:fluttermovie/models/featuredmoviemodel.dart';
import 'package:fluttermovie/models/genremodel.dart';
import 'package:fluttermovie/ui/screens/about.dart';
import 'package:fluttermovie/ui/screens/login_screen.dart';
import 'package:fluttermovie/ui/screens/saved.dart';
import 'package:fluttermovie/ui/screens/search.dart';

import 'package:fluttermovie/ui/widgets/homepagefeaturedwidget.dart';
import 'package:fluttermovie/ui/widgets/widgets.dart';
import 'package:fluttermovie/ui/screens/mydrawerheader.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<FeaturedMovieModel>> featuredMovies;
  late Future<List<GenreModel>> genreList;
  late Api _api;
  @override
  void initState() {
    super.initState();
    _api = Api();
    featuredMovies = _api.getFeaturedMovies();
    genreList = _api.getGenreList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //menu

        drawer: Theme(
          //trong suoots
          data: Theme.of(context).copyWith(
            // Set the transparency here
            canvasColor: Colors
                .transparent, //or any other color you want. e.g Colors.blue.withOpacity(0.5)
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            child: Drawer(
              child: Container(
                // color: Colors.transparent,
                child: SingleChildScrollView(
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        right: BorderSide(width: 1.0, color: Colors.white),
                      ),
                    ),
                    child: Column(
                      children: [
                        MyHeaderDrawer(),
                        MyDrawerList(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),

        //

        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Color(0xff003333),
          elevation: 0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search, color: Colors.white),
              onPressed: () {
                showSearch(context: context, delegate: SearchMovie());
              },
            ),
          ],
          title: Text(
            "TMDB",
            style: Theme.of(context)
                .textTheme
                .headline6!
                .apply(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 2,
                child: FutureBuilder<List<FeaturedMovieModel>>(
                  future: featuredMovies,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return HomePageFeaturedWidget(snapshot: snapshot);
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 5.0),
                height: 50,

                //hiển thị một CircularProgressIndicator. Sau đó, khi nhận được dữ liệu, nó sẽ chuyển sang HomePageFeaturedWidget và chuyển ảnh chụp nhanh dữ liệu dưới dạng một biến.
                //Sau đó, HomePageFeaturedWidget sẽ hiển thị dữ liệu tương ứng
                child: FutureBuilder<List<GenreModel>>(
                  future: genreList,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (ctx, id) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  10.0), //action adventure...
                              color: Color(0xff003333), //màu khung action,...
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 14.0,
                                    offset: Offset(0, 1))
                              ],
                            ),
                            constraints: BoxConstraints(minWidth: 100),
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(
                              horizontal: 7,
                              vertical: 5.0,
                            ),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Text(
                              "${snapshot.data![id].name}", //action ...
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .apply(color: Colors.white),
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
              SizedBox(
                height: 18,
              ),
              SectionContainer(
                sectionTitle: "Trending",
                child: Container(
                  height: MediaQuery.of(context).size.height /
                      2.8, //Cao poster từng phim

                  //hiển thị một CircularProgressIndicator. Sau đó, khi nhận được dữ liệu, nó sẽ chuyển sang HomePageFeaturedWidget và chuyển ảnh chụp nhanh dữ liệu dưới dạng một biến.
                  child: FutureBuilder<List<FeaturedMovieModel>>(
                    future: featuredMovies,
                    builder: (ctx, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (ctx, id) {
                            return MovieContainer(snapshot: snapshot.data![id]);
                          },
                        );
                      } else {
                        return Center(
                          child:
                              CircularProgressIndicator(), //hinh tron loading
                        );
                      }
                    },
                  ),
                ),
              ),
              SectionContainer(
                //Build ben section_container.dart
                sectionTitle: "What's Popular",
                child: Container(
                  height: MediaQuery.of(context).size.height / 2.8,

                  // /hiển thị một CircularProgressIndicator. Sau đó, khi nhận được dữ liệu, nó sẽ chuyển sang HomePageFeaturedWidget và chuyển ảnh chụp nhanh dữ liệu dưới dạng một biến.
                  child: FutureBuilder<List<FeaturedMovieModel>>(
                    future: featuredMovies,
                    builder: (ctx, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (ctx, id) {
                            return MovieContainer(snapshot: snapshot.data![id]);
                          },
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget MyDrawerList() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.black.withOpacity(0.4),
      padding: EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        children: [
          AboutItem(),
          SaveItem(),
          LogoutItem(),
        ],
      ),
    );
  }

  Widget AboutItem() {
    return Material(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AboutPage(),
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  Icons.account_balance,
                  size: 20,
                  color: Colors.white,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  "Profile",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget SaveItem() {
    return Material(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SavedPage(),
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  Icons.bookmark_add_outlined,
                  size: 20,
                  color: Colors.white,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  "My movies",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget LogoutItem() {
    return Material(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  Icons.wrap_text,
                  size: 20,
                  color: Colors.white,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  "Exit",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
