import 'package:anokha_home/registeredEventsCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

const itemSize = 280.0;

class RegisteredEvents extends StatefulWidget {
  RegisteredEvents({Key? key}) : super(key: key);

  @override
  State<RegisteredEvents> createState() => _RegisteredEventsState();
}

class _RegisteredEventsState extends State<RegisteredEvents> {
  final scrollController = ScrollController();
  final searchController = TextEditingController();

  void onListen() {
    setState(() {});
  }

  @override
  void initState() {
    scrollController.addListener(onListen);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.removeListener(onListen);
    super.dispose();
  }


  void onSearch() {
    // Perform search using the searchController.text value
    print('Performing search for ${searchController.text}');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Padding(
            padding: EdgeInsets.only(top: 5),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFF5F5F5),
               borderRadius: BorderRadius.circular(30.0)
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 20, top: 3, bottom: 3),
                child: TextFormField(
                  style: TextStyle(
                    fontSize: 19
                  ),
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Search Card',
                    border: InputBorder.none,

                  ),
                ),
              ),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: IconButton(
                iconSize: 30,
                onPressed: onSearch,
                icon: Icon(Icons.search,
                color: Colors.black,),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(0.0),
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  constraints: BoxConstraints.expand(
                      height: MediaQuery.of(context).size.height * 0.13),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    final itemPositionOffset = index * itemSize * 0.7;
                    final difference =
                        scrollController.offset - itemPositionOffset;
                    if (index == 0) print("UFF ${difference }");
                    final percent = 1.2 - difference / itemSize * 0.7;
                    double opacity = percent;
                    double scale = percent;
                    if (opacity >= 1.0) opacity = 1.0;
                    if (opacity < 0.0) opacity = 0.0;
                    if (percent >= 1.0) scale = 1.0;
                    return Align(
                      heightFactor: 0.7,
                      child: Opacity(
                        opacity: opacity,
                        child: Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.identity()..scale(scale, 1.0),
                          child: RegisteredEventCard(),
                        ),
                      ),
                    );
                  },
                  childCount: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
