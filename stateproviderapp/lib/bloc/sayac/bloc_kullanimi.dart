import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stateproviderapp/bloc/sayac/sayac_bloc.dart';
import 'package:stateproviderapp/bloc/sayac/sayac_event.dart';


class BlocKullanimi extends StatefulWidget {


  @override
  _BlocKullanimiState createState() => _BlocKullanimiState();
}

class _BlocKullanimiState extends State<BlocKullanimi> {

  final _sayacBloc = SayacBloc();


  @override
  void dispose() {
    // TODO: implement dispose

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
            Text("Bloc Kullanımı"),
            StreamBuilder(
                initialData: 0,
                stream: _sayacBloc.sayac,
                builder: (context, snapshot) {
              return Text(snapshot.data.toString(),style: TextStyle(fontSize: 34),);
            }),
            FloatingActionButton(
              heroTag: "1",
              onPressed: () {
                _sayacBloc.sayacEventSink.add(ArttirmaEvent());
              },
              tooltip: 'Increment',
              child: Icon(Icons.add),
            ),
            // SizedBox(height: 5,),
            FloatingActionButton(
              heroTag: "2",
              onPressed: () {
                _sayacBloc.sayacEventSink.add(AzaltmaEvent());
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
