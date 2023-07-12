import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmployeeDashboardScreen extends StatefulWidget {
  @override
  State<EmployeeDashboardScreen> createState() =>
      _EmployeeDashboardScreenState();
}

class _EmployeeDashboardScreenState extends State<EmployeeDashboardScreen> {
  String _searchQuery = '';
  bool _isVisible = true;
  ScrollController _controller;

  void _performSearch(String query) {
    // Perform search action here
    print('Searching for: $query');
    // ...
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller = PrimaryScrollController.of(context);
    _scrollListener();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          backgroundColor: Color(0xFF009CBF),
          automaticallyImplyLeading: false, // Remove the back arrow button
          title: Row(
            children: [
              CircleAvatar(
                radius: 16.0,
                backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80',
                ),
              ),
              SizedBox(
                width: 8.0,
              ), // Add spacing between the avatar and the title
              Text('Search'),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                // Open search delegate
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(),
                );
              },
            ),
          ],
        ),
        //...
        body: Column(
          children: [
            Flexible(
              child: ListView.builder(
                controller: _controller,
                itemCount: 100, // Only one item in the list
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 6.0, bottom: 8.0),
                      child: Container(
                        height: 562,
                        width: 400,
                        color: Colors.white,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 30.0,
                                        backgroundImage: Image.network(
                                          'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80',
                                        ).image,
                                      ),
                                      SizedBox(width: 6.0),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'John Doe',
                                            style: TextStyle(
                                              fontSize: 24.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                          Text(
                                            'Software Engineer',
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.grey,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 16.0),
                                  Text(
                                    'Experience',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    'Software Engineer - XYZ Company\nJan 2020 - Present',
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    'Front-end Developer - ABC Company\nJan 2018 - Dec 2019',
                                  ),
                                ],
                              ),
                            ),
                            Image.asset('assets/images/programming.jpg'),
                            SizedBox(height: 20),
                            Divider(
                              color:
                                  Colors.grey, // Set the color of the divider
                              thickness:
                                  1.0, // Set the thickness or hardness of the divider
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Icon(
                                      Icons.thumb_up_alt_outlined,
                                      size: 20,
                                    ),
                                    Text(
                                      'Like',
                                      style: TextStyle(fontSize: 10),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Icon(
                                      Icons.comment,
                                      size: 20,
                                    ),
                                    Text(
                                      'Comment',
                                      style: TextStyle(fontSize: 10),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Icon(
                                      Icons.repeat,
                                      size: 20,
                                    ),
                                    Text(
                                      'Repost',
                                      style: TextStyle(fontSize: 10),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Icon(
                                      Icons.send,
                                      size: 20,
                                    ),
                                    Text(
                                      'Send',
                                      style: TextStyle(fontSize: 10),
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: _isVisible ? kBottomNavigationBarHeight : 0,
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: Colors.grey,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                label: 'Network',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                  color: Colors.grey,
                ),
                label: 'Settings',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite,
                  color: Colors.grey,
                ),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  color: Colors.grey,
                ),
                label: 'Profile',
              ),
            ],
            selectedItemColor:
                Colors.black, // Color for both selected icon and label text
            unselectedItemColor: Colors.grey,
            unselectedFontSize:
                10, // Color for both unselected icon and label text
            showSelectedLabels: true,
            showUnselectedLabels: true,
          ),
        ),
      ),
    );
  }

  void _scrollListener() {
    _controller.addListener(() {
      if (_controller.position.userScrollDirection == ScrollDirection.reverse) {
        setState(() {
          _isVisible = false;
        });
      }
      if (_controller.position.userScrollDirection == ScrollDirection.forward) {
        setState(() {
          _isVisible = true;
        });
      }
    });
  }
}

class CustomSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Text('Search results for: $query'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Implement suggestions based on the query
    return Container();
  }
}
