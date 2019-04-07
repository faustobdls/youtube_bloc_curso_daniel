import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:curso_youtube_bloc/models/video.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:convert';
import 'dart:async';

class FavoriteBloc implements BlocBase {
  
  Map<String, Video> _favorites = {};

  final  _favController = BehaviorSubject<Map<String, Video>>();
  Stream<Map<String, Video>> get getFavorites => _favController.stream;

  FavoriteBloc() {
    SharedPreferences.getInstance().then( (prefs) {
      if ( prefs.getKeys().contains('favorites')) {
        _favorites = json.decode(prefs.getString('favorites')).map( (id, video) {
          MapEntry(id, Video.fromJson(video));
        }).cast<String, Video>();
        _favController.add(_favorites);
      } else {}
    } );
  }

  void toggleFavorite( Video video ) {
    if ( _favorites.containsKey(video.id)) {
      _favorites.remove(video.id);
    } else {
      _favorites[video.id] = video;
    }
    _favController.sink.add(_favorites);

    _saveFav();
  }

  void _saveFav() {
    SharedPreferences.getInstance().then( (prefs) {
      prefs.setString('favorites', json.encode(_favorites));
    });
  }

  @override
  void dispose() {
    _favController.close();
  }

}