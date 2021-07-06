import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stateproviderapp/auth_service.dart';
import 'package:stateproviderapp/bloc/sayac/bloc_kullanimi.dart';
import 'package:stateproviderapp/counter.dart';
import 'package:stateproviderapp/flutter%20bloc%20paketi%20ile%20sayac%20uygulamas%C4%B1/bloc_paketi_kullanimi.dart';
import 'package:stateproviderapp/sayac_ile_provider.dart';
import 'package:stateproviderapp/stream_kullanimi.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
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
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            RaisedButton(
                child: Text("Sayac With Provider"),
                onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => 
                  MultiProvider(
                   providers: [
                     ChangeNotifierProvider(create: (_) => Counter(0),),
                     ChangeNotifierProvider(create: (_) => AuthService(),),
                   ],
                      child: SayacWithProvider(),
                  ),
              ),
              );
            }),
            RaisedButton(
                child: Text("Sayac With Provider / Stream Kullanımı"),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => StreamKullanimi(),
                  ),
                  );
                }),
            RaisedButton(
                child: Text("Bloc Kullanımı"),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => BlocKullanimi(),
                  ),
                  );
                }),
            RaisedButton(
                child: Text("Bloc Kullanımı / Flutter Block Paketinin kullanımı "),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => BlocPaketiKullanimi(),
                  ),
                  );
                }),
          ],
        ),
      ),
      floatingActionButton: MyButton(_incrementCounter), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class MyButton extends StatefulWidget {

  Function incrementCounter;
  MyButton(this.incrementCounter);

  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return  FloatingActionButton(
      onPressed: widget.incrementCounter,
      tooltip: 'Increment',
      child: Icon(Icons.add),
    );
  }
}



