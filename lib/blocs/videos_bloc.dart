import 'dart:async';
import 'dart:ui';

import 'package:flutter_tube/api.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_tube/models/video.dart';

class VideosBloc implements BlocBase {

  late Api api;
  late List<Video> videos;

  final StreamController<List<Video>> _videosController = StreamController<List<Video>>();
  Stream get outVideos => _videosController.stream;

  final StreamController<String> _searchController = StreamController<String>();
  Sink get inSearch => _searchController.sink;

  VideosBloc(){
    api = Api();

    _searchController.stream.listen(_search);
  }

  void _search(String search) async{
    if(search != ''){
      _videosController.sink.add([]);
      videos = await api.search(search);
    } else {
      videos += await api.nextPage();
    }
    _videosController.sink.add(videos);
  }

  @override
  void dispose() {
    _videosController.close();
    _searchController.close();
  }

  @override
  void addListener(VoidCallback listener) {
    // TODO: implement addListener
  }

  @override
  // TODO: implement hasListeners
  bool get hasListeners => throw UnimplementedError();

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
  }

  @override
  void removeListener(VoidCallback listener) {
    // TODO: implement removeListener
  }

}