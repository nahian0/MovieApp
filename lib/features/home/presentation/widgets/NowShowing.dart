import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:myapp/features/Navbar/presentation/pages/Navbar.dart';
import 'package:myapp/features/details/presentation/pages/DetailsPage.dart';
import 'package:myapp/features/home/data/datasources/apiServicesNowShowing.dart';
import 'package:myapp/features/home/data/repositories/now_showing_repository_impl.dart';
import 'package:myapp/features/home/presentation/widgets/screensize.dart';

int _page = 1;

class NowShowing extends StatefulWidget {
  const NowShowing({super.key});

  @override
  State<NowShowing> createState() => _NowShowingState();
}

class _NowShowingState extends State<NowShowing> {
  final ScrollController _scrollcontroller = ScrollController();
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  void initState() {
    bool _callnewpage = false;

    _scrollcontroller.addListener(() {
      setState(() {
        _callnewpage = _scrollcontroller.offset >
                _scrollcontroller.position.maxScrollExtent - 5
            ? true
            : false;
        if (_callnewpage == true) {
          setState(() {
            final service = ApiServiceNowPlaying();
            _page = _page + 1;
            service.getNowPlayingMovie(_page);
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      drawer: Navbar(),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(
              height: height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => _globalKey.currentState?.openDrawer(),
                  child: Icon(
                    Icons.menu,
                    color: Color(0xFF201d52),
                  ),
                ),
                Text(
                  "FilmKu",
                  style: TextStyle(
                      fontSize: 25,
                      color: Color(0xFF201d52),
                      fontWeight: FontWeight.bold),
                ),
                Icon(
                  Icons.notifications_outlined,
                  color: Color(0xFF201d52),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Now Showing",
                  style: TextStyle(
                      fontSize: 25,
                      color: Color(0xFF201d52),
                      fontWeight: FontWeight.bold),
                ),
                Container(
                    height: 30,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black54),
                    ),
                    child: Center(child: Text("See more"))),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: height * 0.45,
              width: width,
              child: ListView.builder(
                  itemCount: movieList.length,
                  scrollDirection: Axis.horizontal,
                  controller: _scrollcontroller,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Detailspage(
                              tittle: movieList[index].title!,
                              description: movieList[index].overview!,
                              average_vote: movieList[index].voteAverage!,
                              backdroppictures: movieList[index].backdropPath!,
                            ),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Container(
                            height: height * 0.35,
                            width: width * 0.4,
                            margin: EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                    'https://image.tmdb.org/t/p/w500/' +
                                        movieList[index].posterPath!,
                                  ),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Container(
                            height: height * 0.05,
                            width: width * 0.4,
                            child: Center(
                              child: Text(
                                //movieList[index].title,
                                movieList[index].title!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF201d52),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Text(movieList[index].voteAverage! + "/10",
                                  style: TextStyle(color: Colors.grey)),
                              SizedBox(
                                width: 3,
                              ),
                              Text("IMDB",
                                  style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}