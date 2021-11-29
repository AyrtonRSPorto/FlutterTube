import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tube/api.dart';
import 'package:flutter_tube/blocs/favorite_bloc.dart';
import 'package:flutter_tube/blocs/videos_bloc.dart';

import 'screens/home.dart';


void main(){
  Api api = Api();
  api.search("eletro");
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc((i) => VideosBloc()),
        Bloc((i) => FavoriteBloc())
      ],
      dependencies: [],
      child: MaterialApp(
        title: "FlutterTube",
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),

    );
  }
}