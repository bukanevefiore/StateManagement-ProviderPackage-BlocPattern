import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stateproviderapp/bloc_plugin/sayac_bloc.dart';

part 'sayici_state.dart';

class SayiciCubit extends Cubit<SayiciState> {
  SayiciCubit() : super(SayiciState(0));


  void arttir() {
    emit(SayiciState(state._deger + 1));
  }

  void aqzalt() {
    emit(SayiciState(state._deger - 1));
  }

}
