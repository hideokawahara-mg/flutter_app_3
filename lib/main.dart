import 'package:flutter/material.dart';
import 'package:instagram_media/instagram_media.dart';
import 'package:instagram_media_picker/instagram_media_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo23',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int _counter = 0;

  // void _incrementCounter() {
  //   setState(() {
  //     // This call to setState tells the Flutter framework that something has
  //     // changed in this State, which causes it to rerun the build method below
  //     // so that the display can reflect the updated values. If we changed
  //     // _counter without calling setState(), then the build method would not be
  //     // called again, and so nothing would appear to happen.
  //     _counter++;
  //   });
  // }
  var imageUrls = [];
  var imageCaptions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          InkWell(
            onTap: () {
              _getIGMedia(context);
            },
            child: Container(
                width: 200,
                height: 100,
                color: Colors.amber,
                child: Center(child: Text('IG PICKER'))),
          ),
          StreamBuilder(
              stream: Stream.value(imageUrls),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Center(child: Text('Null data'));
                }
                if ((snapshot.data).length == 0) {
                  return Center(child: Text('No Media to Display'));
                } else {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height - 200,
                      child: GridView.count(
                          crossAxisCount: 3,
                          childAspectRatio:
                              ((MediaQuery.of(context).size.width * 0.22) /
                                  100),
                          children: List.generate(imageUrls.length, (index) {
                            return Column(
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.33,
                                  height: 120,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      color: Colors.grey,
                                      image: DecorationImage(
                                          image: NetworkImage(imageUrls[index]),
                                          fit: BoxFit.cover)),
                                ),
                                Text(_determineText(imageCaptions[index]))
                              ],
                            );
                          })));
                }
              })
        ],
      ),
    );
  }

  _getIGMedia(context) async {
    // final result = await Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => InstagramMedia(
    //             mediaTypes: 0,
    //             appID: '514290619574782',
    //             appSecret: 'ebbb18a155690752b54363699953cad8')));
    // setState(() {
    //   imageUrls = result[0];
    //   imageCaptions = result[4];
    // });
    // print(result[0]); //urls
    // print(result[1]); //timestamps
    // print(result[2]); //IDs
    // print(result[3]); //types (IMAGE, VIDEO, or CAROUSEL_ALBUM)
    // print(result[4]); //captions
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => InstagramMediaPicker(
                appID: '514290619574782', //IG app ID from FB Developer Account
                appSecret: 'ebbb18a155690752b54363699953cad8' //App Secret
                )));
    print(result);
  }

  _determineText(input) {
    if (input == null) {
      return 'No Captions';
    } else {
      return input;
    }
  }
}

//
