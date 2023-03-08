import 'package:anokha_home/rive_assets.dart';
import 'package:anokha_home/rowOfCards.dart';
import 'package:anokha_home/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:rive/rive.dart';
import 'package:simple_gravatar/simple_gravatar.dart';


import 'animated_bar.dart';
import 'homeBody.dart';
import 'homeEventCard.dart';

class HomeWidget extends StatefulWidget {
  String gravatar_url;
  HomeWidget({Key? key,
  required this.gravatar_url}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [


          Padding(
            child:
            GestureDetector(
              child: Icon(Icons.search,
                size: 30.0,
                color: Color(0xFF002845),
              ),
              onTap: (){

                showSearch(
                    context: context,
                    delegate: CustomSearchDelegate());

              },
            )
              ,
            padding: EdgeInsets.only(right: 20.0, left: 20.0, bottom: 20.0)
          ),



          GestureDetector(
            onTap: (){

            },
            child: Padding(
              child: Image(image: NetworkImage(widget.gravatar_url),
              width: 40.0,
              ),
              padding:  EdgeInsets.only(right: 20.0, left: 20.0, bottom: 20.0),

            ),
          )
        ],
      ),
      body: HomeBody()
    );
  }


}



class CustomSearchDelegate extends SearchDelegate {
  List<String> searchTerms = [
    "Popular Events",
    "Day 1 Events",
    "Day 2 Events",
    "Day 3 Events",
    "Workshops",
    "Technical Events"
  ];

  String _query = '';

  set query(String value) {
    _query = value;
  }

  void _onQueryChanged() {
    if(query == "")
      {
        searchTerms = [
          "Popular Events",
          "Day 1 Events",
          "Day 2 Events",
          "Day 3 Events",
          "Workshops",
          "Technical Events"
        ];
      }
    else{
      searchTerms.add(query);
    }
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      SizedBox()
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
    // Implement your search results here based on the current query
    return ListView.builder(
      itemCount: searchTerms.length,
      itemBuilder: (context, index){
        var result = searchTerms[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged();

    // Implement your search suggestions here based on the current query
    return ListView.builder(
      itemCount: searchTerms.length,
      itemBuilder: (context, index){
        var result = searchTerms[index];
        return TextButton(
            onPressed: (){},
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Container(
                alignment: Alignment.topLeft,
                child: Text(result,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 17,

                ),),
              ),
            ));
      },
    );
  }
}




