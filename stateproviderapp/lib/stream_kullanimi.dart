import 'dart:async';

import 'package:flutter/material.dart';


class StreamKullanimi extends StatefulWidget {


  @override
  _StreamKullanimiState createState() => _StreamKullanimiState();
}

class _StreamKullanimiState extends State<StreamKullanimi> {

  final StreamController<int> _streamController = StreamController<int>();
  int _counter = 0;

  @override
  void dispose() {
    // TODO: implement dispose
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Stream Kullanımı"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Strream Kullanımı"),
            StreamBuilder(
                initialData: 0,
                stream: _streamController.stream,
                builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              return Text("${snapshot.data}",
                style: Theme.of(context).textTheme.headline4,);
            }),
            FloatingActionButton(
              heroTag: "1",
              //onPressed: mySayac.arttir,
              onPressed: () {
                _streamController.sink.add(++_counter);
              },
              tooltip: 'Increment',
              child: Icon(Icons.add),
            ),
            // SizedBox(height: 5,),
            FloatingActionButton(
              heroTag: "2",
              //onPressed: mySayac.azalt,
              onPressed: () {
                _streamController.sink.add(--_counter);
              },
              tooltip: 'Increment',
              child: Icon(Icons.remove),
            ),
          ],
        ),
      ),
    );
  }
}
