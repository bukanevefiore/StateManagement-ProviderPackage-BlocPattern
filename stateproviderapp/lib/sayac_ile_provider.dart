import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stateproviderapp/auth_service.dart';
import 'package:stateproviderapp/counter.dart';

void main() {
  runApp(SayacWithProvider());
}

class SayacWithProvider extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    final myAuth = Provider.of<AuthService>(context);

    switch (myAuth.durum) {
      case KullaniciDurumu.OturumAciliyor:
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      case KullaniciDurumu.OturumAcilmamis:
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("Lütfen oturum açın"),
                  RaisedButton(onPressed: () async {
                    await myAuth.createUserWithEmailAndPassword("denem@gmail.com", "password");
                  },child: Text("Kullanıcı oluştur"),),
                  RaisedButton(onPressed: () async {
                    await myAuth.signinUserWithEmailAndPassword("denem@gmail.com", "password");
                  },child: Text("Oturum açın"),),
            ],
          ),
        ),
    );
      case KullaniciDurumu.OturumAcilmis:
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(

          primarySwatch: Colors.blue,
          ),
          home: MyHomePage(title: 'Flutter Demo Home Page'),
        );
  }


  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(
        child: MyColumn(),
      ),
      floatingActionButton: MyFloatingActionButtons(),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class MyColumn extends StatelessWidget {
  const MyColumn({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //var mySayac = Provider.of<Counter>(context);
    final myAuth = Provider.of<AuthService>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'sayac : ' + context
              .watch<Counter>()
              .sayac
              .toString(),
          style: Theme
              .of(context)
              .textTheme
              .headline4,
        ),
        Text(context.read<AuthService>().user.email,
          style: Theme
              .of(context)
              .textTheme
              .headline4,
        ),
        RaisedButton(
            child: Text("Çıkış yap"),
            onPressed: () async {
          //await myAuth.signOut();
              await context.read<AuthService>().signOut();
        })
      ],
    );
  }
}

class MyFloatingActionButtons extends StatelessWidget {

  MyFloatingActionButtons({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //var mySayac = Provider.of<Counter>(context,listen: false);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        FloatingActionButton(
          heroTag: "1",
          //onPressed: mySayac.arttir,
          onPressed: () {
            context.read<Counter>().arttir();
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
        // SizedBox(height: 5,),
        FloatingActionButton(
          heroTag: "2",
          //onPressed: mySayac.azalt,
          onPressed: () {
            context.read<Counter>().azalt();
          },
          tooltip: 'Increment',
          child: Icon(Icons.remove),
        ),
      ],
    );
  }
}






