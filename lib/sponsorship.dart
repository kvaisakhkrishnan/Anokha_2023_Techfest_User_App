import 'package:flutter/material.dart';
// import '../Widgets/sliver_list.dart';

class sponsorshipPage extends StatefulWidget {
  const sponsorshipPage({Key? key}) : super(key: key);

  @override
  State<sponsorshipPage> createState() => _sponsorshipPageState();
}

class _sponsorshipPageState extends State<sponsorshipPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          SliverAppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0.0,
            pinned: true,
            centerTitle: false,
            expandedHeight: MediaQuery.of(context).size.height * 0.4,
            flexibleSpace: const FlexibleSpaceBar(
              background: Image(
                image: NetworkImage(
                    'https://s3-prod.adage.com/s3fs-public/20220923_apple_music_3x2.jpg'),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03, left: MediaQuery.of(context).size.width * 0.05),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: Text("Sponsor 1",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.03)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01, left: MediaQuery.of(context).size.width * 0.05, right: MediaQuery.of(context).size.width * 0.05),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        // borderRadius: BorderRadius.circular(20.0),
                      ),
                      // tileColor: Colors.red,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.03),
                      image: DecorationImage(

                        image: AssetImage('assets/images/anokha_timer2.png'),fit: BoxFit.cover,
                      )
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03, left: MediaQuery.of(context).size.width * 0.05),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: Text("Sponsor 1",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.03)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01, left: MediaQuery.of(context).size.width * 0.05, right: MediaQuery.of(context).size.width * 0.05),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        // borderRadius: BorderRadius.circular(20.0),
                      ),
                      // tileColor: Colors.red,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.03),
                      image: DecorationImage(

                        image: AssetImage('assets/images/anokha_timer2.png'),fit: BoxFit.cover,
                      )
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
