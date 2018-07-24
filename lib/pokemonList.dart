import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:pokedex/models/pokemon.dart';

import 'package:pokedex/pokemonServices.dart';
import 'package:pokedex/pokemonProfile.dart';

var client = new http.Client();
final pokemonServices = new PokemonServices();

void main() => runApp(new PokemonList());

class PokemonList extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: new PokemonListStateful(),
      routes: <String, WidgetBuilder> {
        'pokemonProfile': (BuildContext context) => new PokemonProfile()
      },
    );
  }
}

class PokemonListStateful extends StatefulWidget {
  @override
  PokemonListState createState() => new PokemonListState();
}

class PokemonListState extends State<PokemonListStateful> {
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return pokemonScaffold(context);
  }

  Widget pokemonScaffold(BuildContext context) {

    return new Scaffold(
        appBar: new AppBar(
          title: new Text('POKEDEX'),
        ),
        body: pokemonList(context)
    );
  }

  Widget pokemonList(BuildContext context) {
    return new FutureBuilder(
        future: pokemonServices.fetchPokemonList(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? pokemonListView(context, snapshot.data)
              : Center(child: CircularProgressIndicator());
        }
    );
  }

  Widget pokemonListView(BuildContext context, List<Pokemon> pokemon) {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(pokemon.length, (index) {
        return new Center(
          child: pokemonListTile(context, pokemon[index], index)
        );
      }),
    );

  }

  Widget pokemonListTile(BuildContext context, Pokemon pokemon, int index) {
    return new ListTile(
      title: Image.asset('images/${(index + 1)}.png', width: 100.0, height: 100.0),
      subtitle:  Text(
        pokemon.name,
        textAlign: TextAlign.center,
      ),
      onTap: () {
        var route = new MaterialPageRoute(builder: (BuildContext build) => new PokemonProfile(pokemon: pokemon));

        Navigator.of(context).push(route);

//        Navigator.of(context).pushNamed('pokemonProfile');
//        new FutureBuilder(
//          future: pokemonServices.fetchPokemonDetails(pokemon.url),
//          builder: (context, snapshot) {
//            if (snapshot.hasError) print(snapshot.error);
//            print(snapshot.hasData);
//            return snapshot.hasData
//                ? Navigator.push(
//                  context,
//                  MaterialPageRoute(builder: (context) => PokemonProfile())
//                )
//                : Center(child: CircularProgressIndicator());
//          },
//        );
      },
    );
  }
}