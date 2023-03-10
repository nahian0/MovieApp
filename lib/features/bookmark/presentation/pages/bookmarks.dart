import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/core/di/app_component.dart';
import 'package:myapp/features/bookmark/domain/repositories/bookmarks_Repository.dart';

import 'package:myapp/features/bookmark/domain/usecases/getBookmarksdatausecase.dart';
import 'package:myapp/features/bookmark/presentation/bloc/bookmark_bloc.dart';
import 'package:myapp/features/home/presentation/bloc/nowshowingbloc/nowshowing_bloc.dart';
import 'package:myapp/features/home/presentation/widgets/Navbar.dart';
import 'package:myapp/core/data/source/bookmarkLocalDatabase.dart';
import 'package:myapp/features/home/presentation/widgets/screensize.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key});

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  List moviegenres = [
    "Action",
    "adventure",
    "comedy",
    "drama",
  ];
  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

    return BlocProvider(
      create: (context) => BookmarkBloc()..add(loadBookmarksdata()),
      child: Scaffold(
        key: _globalKey,
        drawer: Navbar(),
        body: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => _globalKey.currentState?.openDrawer(),
                    child: Container(
                      child: Icon(
                        Icons.menu,
                        color: Color(0xFF201d52),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.3,
                  ),
                  Text(
                    "Bookmarks",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              BlocBuilder<BookmarkBloc, BookmarkState>(
                builder: (context, state) {
                  if (state is bookmarkDataloaded) {
                    //print(state.bookmarks);
                    return Container(
                      height: height * 0.9,
                      child: ListView.builder(
                          itemCount: state.bookmarks.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              height: height * 0.20,
                              margin: EdgeInsets.only(
                                right: 10,
                                top: 30,
                                left: 5,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Color.fromARGB(255, 240, 241, 243),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 8,
                                    blurRadius: 8,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: height * 0.17,
                                    width: width * 0.25,
                                    margin: EdgeInsets.only(
                                        left: width * 0.07,
                                        top: height * 0.015),
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: CachedNetworkImageProvider(
                                                'https://image.tmdb.org/t/p/w500/' +
                                                    state.bookmarks[index]
                                                        ['poster_path']),
                                            fit: BoxFit.fill),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: width * 0.02, top: height * 0.02),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: height * 0.05,
                                          width: width * 0.4,
                                          child: Text(
                                            state.bookmarks[index]['title'],
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Color(0xFF201d52),
                                                fontWeight: FontWeight.bold),
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
                                            Text(
                                                state.bookmarks[index]
                                                        ['vote_average'] +
                                                    "/10",
                                                style: TextStyle(
                                                    color: Colors.grey)),
                                            SizedBox(
                                              width: 3,
                                            ),
                                            Text("IMDB",
                                                style: TextStyle(
                                                    color: Colors.grey)),
                                          ],
                                        ),
                                        Container(
                                          height: height * 0.03,
                                          width: width * 0.5,
                                          margin: EdgeInsets.only(
                                              top: height * 0.01),
                                          child: ListView.builder(
                                              itemCount: moviegenres.length,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Container(
                                                  height: height * 0.035,
                                                  width: width * 0.2,
                                                  margin: EdgeInsets.only(
                                                    right: 10,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    color: Color.fromARGB(
                                                        255, 207, 218, 247),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      moviegenres[index],
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              143,
                                                              170,
                                                              245)),
                                                    ),
                                                  ),
                                                );
                                              }),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: height * 0.01),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: height * 0.01),
                                                child: Icon(
                                                  Icons.access_time_outlined,
                                                  size: 15,
                                                ),
                                              ),
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      left: width * 0.01),
                                                  child: Text("1 h 48min"))
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      context.read<BookmarkBloc>().add(
                                          delateBookmarkdata(
                                              state.bookmarks[index]['id']));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          right: width * 0.02,
                                          top: height * 0.03),
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                        size: 40,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
