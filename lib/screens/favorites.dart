import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tube/blocs/favorite_bloc.dart';
import 'package:flutter_tube/models/video.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:flutter_tube/api.dart';

class Favorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.getBloc<FavoriteBloc>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Favorites',
          style: TextStyle(color: Colors.black54),),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: StreamBuilder<Map<String, Video>>(
          initialData: {},
          stream: bloc.outFav,
          builder: (context, snapshot){
            return ListView(
              children: snapshot.data!.values.map((v){
                return InkWell(
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 100,
                        height: 50,
                        child: Image.network(v.thumb),
                      ),
                      Expanded(
                        child: Text(
                          v.title, style: const TextStyle(color: Colors.black),
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                  onTap: (){
                    FlutterYoutube.playYoutubeVideoById(
                        apiKey: API_KEY,
                        videoId: v.id
                    );
                  },
                  onLongPress: (){
                    bloc.toggleFavorite(v);
                  },
                );
              }).toList(),
            );
          }),
    );
  }
}
