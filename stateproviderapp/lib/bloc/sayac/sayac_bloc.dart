


import 'dart:async';

import 'package:stateproviderapp/bloc/sayac/sayac_event.dart';

class SayacBloc {

  int _sayac = 0;

  // state için streamController
  final _sayacStateStreamController = StreamController<int>();
  Stream<int> get sayac => _sayacStateStreamController.stream;
  StreamSink<int> get _sayacStateSink => _sayacStateStreamController.sink;


  // sink için streamController
  final _sayacEventStreamController = StreamController<SayacEvent>();
  Stream<SayacEvent> get _sayacEventStream => _sayacEventStreamController.stream;
  StreamSink<SayacEvent> get sayacEventSink => _sayacEventStreamController.sink;

  SayacBloc() {
    _sayacEventStream.listen(_mapEventToState);
  }



  void _mapEventToState(SayacEvent event) {

    if(event is ArttirmaEvent) {
      _sayac++;
    }else{
      _sayac--;
    }

    _sayacStateSink.add(_sayac);
  }
}

