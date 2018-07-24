import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/models/stats.dart';

//class PokemonProfile extends StatelessWidget {
//
//  final Stat stat;
//  PokemonProfile(this.stat);
//
//  @override
//  Widget build(BuildContext context) {
//    return new MaterialApp(
//      title: 'Flutter Demo',
//      theme: new ThemeData(
//        // This is the theme of your application.
//        //
//        // Try running your application with "flutter run". You'll see the
//        // application has a blue toolbar. Then, without quitting the app, try
//        // changing the primarySwatch below to Colors.green and then invoke
//        // "hot reload" (press "r" in the console where you ran "flutter run",
//        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
//        // counter didn't reset back to zero; the application is not restarted.
//        primarySwatch: Colors.blue,
//      ),
//      home: new PokemonProfileStateful(),
//    );
//  }
//}

class PokemonProfile extends StatefulWidget {

  final Pokemon pokemon;
  PokemonProfile({Key key, this.pokemon}) : super (key: key);

  @override
  PokemonProfileState createState() => new PokemonProfileState();
}

class PokemonProfileState extends State<PokemonProfile> {
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return pokemonProfileScaffold(context);
  }

  Widget pokemonProfileScaffold(BuildContext context) {

    return new Scaffold(
        appBar: new AppBar(
          title: new Text(widget.pokemon.name),
        ),
    );
  }

}