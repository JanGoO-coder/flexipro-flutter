import 'package:flutter/material.dart';

class UserDashboardScreen extends StatefulWidget {
  @override
  State<UserDashboardScreen> createState() => _UserDashboardScreenState();
}

class _UserDashboardScreenState extends State<UserDashboardScreen> {
  String _searchQuery = '';

  void _performSearch(String query) {
    // Perform search action here
    print('Searching for: $query');
    // ...
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          automaticallyImplyLeading: false, // Remove the back arrow button
          title: Row(
            children: [
              CircleAvatar(
                radius: 16.0,
                backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1974&q=80',
                ),
              ),
              SizedBox(
                  width: 8.0), // Add spacing between the avatar and the title
              Text('Search Bar Example'),
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
        body: Container(
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: Container(
              height: 500,
              width: 400,
              color: Colors.white,
              child: ListView.builder(
                itemCount: 1, // Only one item in the list
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 50.0,
                          backgroundImage: Image.network(
                            'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1974&q=80',
                          ).image,
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          'John Doe',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Software Engineer',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          'About',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed lobortis, tellus non ullamcorper fringilla, ligula urna cursus mauris, in semper odio velit eget orci.',
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
                        SizedBox(height: 16.0),
                        Text(
                          'Education',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Bachelor of Science in Computer Science - University XYZ\n2014 - 2018',
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ));
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
