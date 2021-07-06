import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stateproviderapp/cubit_plugin/sayici_cubit.dart';
import 'package:stateproviderapp/flutter%20bloc%20paketi%20ile%20sayac%20uygulamas%C4%B1/counter%20sayac/counter_event.dart';
import 'package:stateproviderapp/themeCubit/theme_cubit.dart';
import 'counter sayac/counter_bloc.dart';
import 'counter sayac/counter_state.dart';

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Custom [BlocObserver] which observes all bloc and cubit instances.
class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(bloc, error, stackTrace);
  }
}

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(BlocPaketiKullanimi());
}


class BlocPaketiKullanimi extends StatelessWidget {
  const BlocPaketiKullanimi({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, tema){
          return MaterialApp(
            title: "Bloc Paketi Kullanımı",
            theme: tema,
            home: MultiBlocProvider(
              providers: [
               BlocProvider( create: (context) => CounterBloc()),
                BlocProvider( create: (context) => SayiciCubit()),
              ],
              child: MyHomePage(),
            ),
          );
        }
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter bloc paketi"),),
      body: MyCenterWidget(),
      floatingActionButton: MyActions(),
    );
  }
}


class MyCenterWidget extends StatelessWidget {
  const MyCenterWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<CounterBloc, CounterState>(
            builder: (context, counterState) =>
              Text(counterState.sayac.toString())),
          // SizedBox(height: 5,),
          BlocBuilder<SayiciCubit, SayiciState>(
              builder: (context, sayiciState) =>
                  Text(sayiciState.deger.toString())),
        ],
      ),
    );
  }
}


class MyActions extends StatelessWidget {
  const MyActions({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FloatingActionButton(
          heroTag: "1",
          onPressed: () {
            // context.bloc<CounterBloc>().add(CounterArttir);
            context.read<CounterBloc>().add(CounterArttir());
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
        FloatingActionButton(
          heroTag: "2",
          onPressed: () {
            context.read<CounterBloc>().add(CounterAzalt());
          },
          tooltip: 'Increment',
          child: Icon(Icons.remove),
        ),
        FloatingActionButton(
          heroTag: "3",
          onPressed: () {
            context.read<ThemeCubit>().temaDegistir();
          },
          tooltip: 'Teme Degistir',
          child: Icon(Icons.wb_sunny),
        ),
        FloatingActionButton(
          heroTag: "4",
          onPressed: () {
            context.read<SayiciCubit>().arttir();
          },
          tooltip: 'Arttir',
          child: Icon(Icons.add_circle_outline),
        ),
      ],
    );
  }
}

