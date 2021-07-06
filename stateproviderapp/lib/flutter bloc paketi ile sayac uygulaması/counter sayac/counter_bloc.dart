

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stateproviderapp/flutter%20bloc%20paketi%20ile%20sayac%20uygulamas%C4%B1/counter%20sayac/counter_event.dart';
import 'package:stateproviderapp/flutter%20bloc%20paketi%20ile%20sayac%20uygulamas%C4%B1/counter%20sayac/counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState(0));

  @override
  Stream<CounterState> mapEventToState(CounterEvent event) async*{

    if(event is CounterArttir) {
      yield CounterState(state.sayac + 1);
    }
    if(event is CounterAzalt) {
      yield CounterState(state.sayac - 1);
      // o an sayac değeri 4 ise ekrana 3 yazdırılır
    }
  }


}