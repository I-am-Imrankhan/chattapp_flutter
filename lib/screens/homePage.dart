import 'package:flutter/material.dart';
import 'package:chattapp_flutter/providers/authenticationProvider.dart';
import 'package:chattapp_flutter/providers/counterViewModel.dart';
import 'package:chattapp_flutter/screens/navigation/navigationbar.dart';
import 'package:chattapp_flutter/providers/firebase_services/firestore-service.dart';
import 'package:provider/provider.dart';


class MyHomePage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    print("MyHomePage is render completely ");
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text("Title"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () {
              context.read<AuthenticationProvider>().signOut();
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Count(),

            //FirestoreService()
          ],
        ),
      ),
      /*floatingActionButton: (Row(
        children: [
          FloatingActionButton(
            onPressed: () =>
                context.read<CounterViewModel>().addUser(),
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
           FloatingActionButton(
            onPressed: () =>
                context.read<CounterViewModel>().incrementCounterbyTow(),
            tooltip: 'Increment',
            child: Icon(Icons.plumbing),
          ),
          FloatingActionButton(
            onPressed: () => context.read<CounterViewModel>().setToNull(),
            tooltip: 'Increment',
            child: Icon(Icons.exposure_zero),
          ), 
        ],
      )),*/
    );
  }
}

class Count extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      '${context.watch<CounterViewModel>().counter}',
      key: Key('counterState'),
      style: Theme.of(context).textTheme.headline3,
    );
  }
}
