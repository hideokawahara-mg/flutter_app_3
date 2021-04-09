import 'package:flutter/material.dart';
// image_picker
import 'package:image_picker/image_picker.dart';

// image_gallery_saver
import 'package:image_gallery_saver/image_gallery_saver.dart';

// esys_flutter_share
import 'package:esys_flutter_share/esys_flutter_share.dart';

import 'dart:io'; //File
import 'dart:typed_data'; // Uint8List
import 'package:share_extend/share_extend.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'esys_flutter_share'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File _image;
  final picker = ImagePicker();

  // 画像の読み込み
  Future _getImage() async {
    //final pickedFile = await picker.getImage(source: ImageSource.camera);//カメラ
    final pickedFile = await picker.getVideo(source: ImageSource.gallery);//アルバム

    if(pickedFile != null) {
      setState((){
        _image = File(pickedFile.path);
      });
    }
  }

  Future _getVideo() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);//アルバム

    if(pickedFile != null) {
      setState((){
        _image = File(pickedFile.path);
      });
    }
  }
 
  // 画像の保存
  Future _saveImage() async {
    if(_image != null) {
      Uint8List _buffer = await _image.readAsBytes();
      final result = await ImageGallerySaver.saveImage(_buffer);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image == null
                ? Text('No image selected.')
                : Image.file(_image),
            ElevatedButton(
              child: Text('画像をアルバムから取得する'),
              onPressed: _getVideo,
            ),
            ElevatedButton(
              child: Text('画像投稿する'),
              // onPressed: () {
              //   Share.text('title', 'Share text.', 'text/plain');
              // },
              onPressed: () async {
                if(_image != null) {
                  Uint8List _buffer = await _image.readAsBytes();
                  await Share.file(
                      'Share image', 'photo.jpg', _buffer, 'image/jpg');
                }
              },
            ),
            ElevatedButton(
              child: Text('動画共有する'),
              onPressed: () async {
                if(_image != null) {
                  ShareExtend.share(_image.path, "video");
                  // Uint8List _buffer = await _image.readAsBytes();
                  // await Share.file(
                  //     'Share image', 'photo.jpg', _buffer, 'image/jpg');
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getImage,
        tooltip: 'Pick',
        child: Text('動画をアルバムから取得する'),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}