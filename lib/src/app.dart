import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
//only get the get function from the http package
import 'models/image_model.dart';
import 'dart:convert';
import 'widgets/image_list.dart';

class App extends StatefulWidget {
  createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  int counter = 0;
  List<ImageModel> images = [];

  void fetchImage() async {
    //to use await async keyword should be used
    counter++;
    var response =
        await get('https://jsonplaceholder.typicode.com/photos/$counter');
    var imageModel = ImageModel.fromJson(json.decode(response
        .body)); //raw json is in respons.body and it is decoded into map by json.deocde
    setState(() {
      //rerendeirng widget
      images.add(
          imageModel); //so that the previous image also shows when the appstate widget rerenders
    });
  }

  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        //white screen
        body: ImageList(images),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed:
              fetchImage, //no parenthesis after fethcImage because if there was parenthesis then fetchImage would be called the moment the bulder method  was invoked
        ),
        appBar: AppBar(
          title: Text('Images'),
        ), //blue appbar at top
      ),
    );
  }
}
